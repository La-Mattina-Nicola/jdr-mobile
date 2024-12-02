import 'package:flutter/material.dart';

class MyItemMenu extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  final Widget? leading;
  final Widget? trailing;
  final Widget? subtitle;
  final void Function()? onTap;

  const MyItemMenu({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    this.color,
    this.leading,
    this.trailing,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListTile(
        title: Text(text, style: TextStyle(fontSize: 15),),
        subtitle: subtitle,
        leading: leading ?? Icon(icon, color: color ?? Theme.of(context).colorScheme.tertiary),
        trailing: trailing,
        onTap: onTap
      ),
    );
  }
}