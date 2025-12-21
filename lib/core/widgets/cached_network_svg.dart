import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CachedNetworkSvg extends StatelessWidget {
  const CachedNetworkSvg({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholderBuilder,
    this.errorBuilder,
    this.color,
  });

  final String url;

  final double? width;

  final double? height;

  final BoxFit fit;

  final WidgetBuilder? placeholderBuilder;

  final Widget Function(BuildContext, Object)? errorBuilder;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: DefaultCacheManager().getSingleFile(url),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorBuilder?.call(context, snapshot.error!) ??
              Icon(
                Icons.error_outline,
                size: width ?? height ?? 24,
                color: Colors.red,
              );
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return SvgPicture.file(
            snapshot.data!,
            width: width,
            height: height,
            fit: fit,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          );
        }

        return placeholderBuilder?.call(context) ??
            SizedBox(
              width: width,
              height: height,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
      },
    );
  }
}
