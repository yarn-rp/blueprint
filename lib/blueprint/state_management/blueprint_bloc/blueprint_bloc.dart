import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:task_repository/task_repository.dart';

part 'blueprint_event.dart';
part 'blueprint_state.dart';

class BlueprintBloc extends Bloc<BlueprintEvent, BlueprintState> {
  BlueprintBloc({
    required BlueprintRepository blueprintRepository,
  })  : _blueprintRepository = blueprintRepository,
        super(BlueprintState()) {
    on<BlueprintRequested>(_onGetBlueprint);
    on<BlueprintTaskItemCreated>(_onBlueprintTaskItemCreated);
    on<BlueprintItemDeleted>(_onBlueprintItemDeleted);
    on<BlueprintItemUpdated>(_onBlueprintItemUpdated);
    on<PreviewItemsAccepted>(_onPreviewItemsAccepted);
    on<PreviewsItemsRejected>(_onPreviewsItemsRejected);
  }

  final BlueprintRepository _blueprintRepository;

  Future<void> _onGetBlueprint(
    BlueprintRequested event,
    Emitter<BlueprintState> emit,
  ) async {
    emit(state.copyWith(status: BlueprintStatus.loading));
    final blueprintStream = _blueprintRepository.getBlueprint();
    final previewStream = _blueprintRepository.previewChangesStream;

    return emit.forEach(
      // combine the blueprint and preview streams
      blueprintStream
          .combineLatest(
            previewStream,
            (a, b) => (items: a, previewItems: b),
          )
          .transform(
            PeriodicEmitTransformer(
              duration: const Duration(seconds: 5),
            ),
          ),
      onData: (value) {
        return state.copyWith(
          items: value.items,
          previewItems: value.previewItems
              .map(
                (e) => e.copyWith(isPreview: true),
              )
              .toList(),
          updatedAt: DateTime.now(),
          status: BlueprintStatus.loaded,
        );
      },
      onError: (error, stackTrace) {
        addError(error, stackTrace);

        return state.copyWith(
          status: BlueprintStatus.error,
        );
      },
    );
  }

  Future<void> _onPreviewItemsAccepted(
    PreviewItemsAccepted event,
    Emitter<BlueprintState> emit,
  ) async {
    try {
      await _blueprintRepository.acceptPreview();
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: BlueprintStatus.error));
    }
  }

  Future<void> _onPreviewsItemsRejected(
    PreviewsItemsRejected event,
    Emitter<BlueprintState> emit,
  ) async {
    emit(state.copyWith(status: BlueprintStatus.loading));

    try {
      _blueprintRepository.clearPreview();

      emit(
        state.copyWith(status: BlueprintStatus.loaded),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: BlueprintStatus.error));
    }
  }

  Future<void> _onBlueprintTaskItemCreated(
    BlueprintTaskItemCreated event,
    Emitter<BlueprintState> emit,
  ) async {
    emit(state.copyWith(status: BlueprintStatus.loading));

    try {
      await _blueprintRepository.addBlueprintItem(
        task: event.task,
        startTime: event.startTime,
        endTime: event.endTime,
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: BlueprintStatus.error));
    }
  }

  Future<void> _onBlueprintItemUpdated(
    BlueprintItemUpdated event,
    Emitter<BlueprintState> emit,
  ) async {
    emit(state.copyWith(status: BlueprintStatus.loading));

    if (event.item.isPreview) {
      _blueprintRepository.updatePreviewItem(
        event.item.copyWith(
          startTime: event.startTime,
          endTime: event.endTime,
        ),
      );
      return;
    }

    try {
      await _blueprintRepository.updateBlueprintItem(
        event.item.copyWith(
          startTime: event.startTime,
          endTime: event.endTime,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: BlueprintStatus.error));
    }
  }

  Future<void> _onBlueprintItemDeleted(
    BlueprintItemDeleted event,
    Emitter<BlueprintState> emit,
  ) async {
    emit(state.copyWith(status: BlueprintStatus.loading));

    if (event.item.isPreview) {
      _blueprintRepository.deletePreviewItem(event.item);
      return;
    }

    try {
      await _blueprintRepository.deleteBlueprintItem(event.item);
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: BlueprintStatus.error));
    }
  }
}

class PeriodicEmitTransformer<S> extends StreamTransformerBase<S, S> {
  PeriodicEmitTransformer({required this.duration});
  final Duration duration;

  @override
  Stream<S> bind(Stream<S> stream) {
    StreamController<S>? controller;
    Timer? timer;
    S? lastValue;

    void onData(S data) {
      lastValue = data;
      if (controller != null && !controller.isClosed) {
        controller.add(lastValue as S);
      }
    }

    void onTick(Timer t) {
      if (lastValue != null && controller != null && !controller.isClosed) {
        controller.add(lastValue as S);
      }
    }

    void startTimer() {
      timer?.cancel();
      timer = Timer.periodic(duration, onTick);
    }

    void onListen() {
      startTimer();
      stream.listen(
        onData,
        onError: controller?.addError,
        onDone: controller?.close,
        cancelOnError: true,
      );
    }

    void onPause() {
      timer?.cancel();
    }

    void onResume() {
      startTimer();
    }

    void onCancel() {
      timer?.cancel();
    }

    controller = StreamController<S>(
      onListen: onListen,
      onPause: onPause,
      onResume: onResume,
      onCancel: onCancel,
    );

    return controller.stream;
  }
}
