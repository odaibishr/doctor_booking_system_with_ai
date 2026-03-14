import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import '../manager/network/network_cubit.dart';
import '../manager/network/network_state.dart';
import 'offline_dialog.dart';

class NetworkStatusWrapper extends StatefulWidget {
  final Widget child;

  const NetworkStatusWrapper({super.key, required this.child});

  @override
  State<NetworkStatusWrapper> createState() => _NetworkStatusWrapperState();
}

class _NetworkStatusWrapperState extends State<NetworkStatusWrapper> {
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    // Listen for route changes to show the dialog once we land on a valid route
    AppRouter.currentRouteName.addListener(_onRouteChange);
  }

  @override
  void dispose() {
    AppRouter.currentRouteName.removeListener(_onRouteChange);
    super.dispose();
  }

  void _onRouteChange() {
    if (_isMainAppRoute()) {
      final state = context.read<NetworkCubit>().state;
      if (state is NetworkDisconnected) {
        _showOfflineDialog();
      }
    }
  }

  void _showOfflineDialog() {
    if (_isDialogShowing) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = AppRouter.navigatorKey.currentContext;
      if (ctx == null) return;

      if (_isDialogShowing) return;
      _isDialogShowing = true;

      showDialog<void>(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext dialogCtx) => const OfflineDialog(),
      ).then((_) {
        _isDialogShowing = false;
      });
    });
  }

  void _closeOfflineDialog() {
    if (_isDialogShowing) {
      final ctx = AppRouter.navigatorKey.currentContext;
      if (ctx != null) {
        Navigator.of(ctx, rootNavigator: true).pop();
      }
      _isDialogShowing = false;
    }
  }

  bool _isMainAppRoute() {
    try {
      final currentRoute = AppRouter.currentRouteName.value;
      
      const excludeRoutes = [
        AppRouter.splashRoute,
        AppRouter.signInViewRoute,
        AppRouter.signupViewRoute,
        AppRouter.createprofileViewRout,
        AppRouter.onboardingViewRoute,
        AppRouter.emailinputViewRoute,
        AppRouter.verifyCodeViewRoute,
        AppRouter.createNewPasswordViewRoute,
      ];

      return !excludeRoutes.contains(currentRoute);
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (BuildContext context, NetworkState state) {
        if (state is NetworkDisconnected) {
          if (_isMainAppRoute()) {
            _showOfflineDialog();
          }
        } else if (state is NetworkConnected ||
            state is NetworkOfflineAcknowledged) {
          _closeOfflineDialog();
        }
      },
      child: widget.child,
    );
  }
}
