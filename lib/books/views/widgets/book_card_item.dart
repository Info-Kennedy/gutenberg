import 'package:flutter/material.dart';
import 'package:gutenberg/books/models/book.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookCardItem extends StatelessWidget {
  final Book book;

  const BookCardItem({super.key, required this.book});

  String getImageUrl(String? originalUrl) {
    if (originalUrl == null || originalUrl.isEmpty) return '';
    return originalUrl;
  }

  Future<void> onBookTap(BuildContext context) async {
    final formats = book.formats;
    final logger = Logger();
    String? url;
    if (formats.textHtml != null && formats.textHtml!.isNotEmpty) {
      url = formats.textHtml;
    } else if (formats.textPlain != null && formats.textPlain!.isNotEmpty) {
      url = formats.textPlain;
    } else if (formats.textPlainCharsetUsAscii != null && formats.textPlainCharsetUsAscii!.isNotEmpty) {
      url = formats.textPlainCharsetUsAscii;
    }
    if (url != null) {
      final uri = Uri.parse(url);
      logger.d("No viewable version available: $url");
      // if (await canLaunchUrl(uri)) {
      // ignore: use_build_context_synchronously
      if (Theme.of(context).platform == TargetPlatform.android || Theme.of(context).platform == TargetPlatform.iOS) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
      // } else {
      //   logger.d("No viewable version available: $url");
      //   // ignore: use_build_context_synchronously
      //   _showNoViewableDialog(context, url);
      // }
    } else {
      logger.d("No viewable version available: $url");
      _showNoViewableDialog(context, url ?? "");
    }
  }

  void _showNoViewableDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('No viewable version available: $url'),
        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onBookTap(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 0.7,
                child: book.formats.imageJpeg != null && book.formats.imageJpeg!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: getImageUrl(book.formats.imageJpeg),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.broken_image, size: 40)),
                        ),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Center(child: Icon(Icons.book, size: 40)),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.title.toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            book.authors.isNotEmpty ? book.authors.first.name : "",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
