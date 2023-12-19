import 'package:atemkraft/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:atemkraft/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:atemkraft/features/auth/presentation/bloc/profile_bloc.dart';
import 'package:atemkraft/features/home/presentation/bloc/bolt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/injections/injections.dart';
import 'features/admin/presentation/bloc/user_plans_bloc/plan_bloc.dart';
import 'firebase_options.dart';

import 'core/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  injectionInit();
  initializeDateFormatting().then((_) => runApp(
        MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (_) => getIt<AuthBloc>(),
              ),
              BlocProvider<AdminBloc>(
                create: (_) => getIt<AdminBloc>(),
              ),
              BlocProvider<BoltBloc>(create: (_) => getIt<BoltBloc>()),
              BlocProvider<ProfileBloc>(create: (_) => getIt<ProfileBloc>()),
              BlocProvider<PlanBloc>(
                create: (_) => getIt<PlanBloc>(),
              ),
            ],
            child: ResponsiveSizer(
              builder: (context, orientation, deviceType) {
                return const MyApp();
              },
            )),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRouter();
  }
}
