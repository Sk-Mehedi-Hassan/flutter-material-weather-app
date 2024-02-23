import 'package:flutter/foundation.dart';
import 'package:location_api/location_api.dart';
import 'package:location_repo/location_repo.dart';
import 'package:bloc/bloc.dart';
part 'location_state.dart';
part 'location_event.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepo _locationRepo;
  LocationBloc({required LocationRepo locationRepo})
      : _locationRepo = locationRepo,
        super(const LocationState()) {
    on<LocationEvent>(_onLocationEvent);
  }

  Future<void> _onLocationEvent(
      LocationEvent event, Emitter<LocationState> emit) async {
    // if location name is empty emit
    // the initial location state

    if (event.locationName.isEmpty) {
      emit(
        const LocationState(
          locationStatus: LocationStatus.initial,
          results: null,
        ),
      );
    } else {
      // start emitting loading status
      // location name is not empty
      // try to fetch location
      try {
        Results results =
            await _locationRepo.fetchLocation(query: event.locationName);
        if (results.results == null) {
          emit(
            const LocationState(
              locationStatus: LocationStatus.loading,
              results: null,
            ),
          );
        } else {
          emit(
            LocationState(
              locationStatus: LocationStatus.success,
              results: results,
            ),
          );
        }
      } catch (e) {
        // if exception encountered
        // emit failure state
        emit(
          const LocationState(
            locationStatus: LocationStatus.failure,
            results: null,
          ),
        );
      }
    }
  }
}
