import 'package:auto_route/auto_route.dart';
import 'package:todo/routing/auth_wrapper.dart';
import 'package:todo/src/features/authentication/presentation/screens/sign_in_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class TodoAppRouter extends _$TodoAppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  // TODO: implement routes
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthWrapperRoute.page,
          path: '/authentication',
          initial: true,
          children: [
            CustomRoute(
              page: SignInRoute.page,
              path: 'sign_in',
            ),
          ],
        ),
      ];
}
