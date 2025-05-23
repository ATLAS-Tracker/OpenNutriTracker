import 'package:flutter/material.dart';
import 'package:opennutritracker/core/domain/entity/user_role_entity.dart';
import 'package:opennutritracker/core/presentation/widgets/spacing.dart';
import 'package:opennutritracker/l10n/s.dart';

class OnboardingRolePageBody extends StatefulWidget {
  final Function(bool active, UserRoleEntity? selectedRole) setPageContent;
  final UserRoleEntity? initialRole;

  const OnboardingRolePageBody({
    super.key,
    required this.setPageContent,
    this.initialRole,
  });

  @override
  State<OnboardingRolePageBody> createState() => _OnboardingRolePageBodyState();
}

class _OnboardingRolePageBodyState extends State<OnboardingRolePageBody> {
  UserRoleEntity? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
    // Call callback initially in case a role is already selected (e.g. navigating back)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.setPageContent(_selectedRole != null, _selectedRole);
    });
  }

  void _onRoleSelected(UserRoleEntity role) {
    setState(() {
      _selectedRole = role;
    });
    widget.setPageContent(true, _selectedRole);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            s.onboardingRoleQuestionSubtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          mediumSpacing(),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              ChoiceChip(
                label: Text(s.coachLabel),
                selected: _selectedRole == UserRoleEntity.coach,
                onSelected: (bool selected) {
                  if (selected) {
                    _onRoleSelected(UserRoleEntity.coach);
                  }
                },
                labelStyle: _selectedRole == UserRoleEntity.coach
                    ? theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                      )
                    : theme.textTheme.labelLarge,
                selectedColor: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.surfaceVariant,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: BorderSide(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
              ChoiceChip(
                label: Text(s.studentLabel),
                selected: _selectedRole == UserRoleEntity.student,
                onSelected: (bool selected) {
                  if (selected) {
                    _onRoleSelected(UserRoleEntity.student);
                  }
                },
                labelStyle: _selectedRole == UserRoleEntity.student
                    ? theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                      )
                    : theme.textTheme.labelLarge,
                selectedColor: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.surfaceVariant,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: BorderSide(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
