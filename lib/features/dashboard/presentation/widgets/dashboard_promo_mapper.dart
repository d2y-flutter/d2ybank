abstract final class DashboardPromoMapper {
  static const String _diningImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCXe0bSZQ3kWpMd1e1OFIGS02UFpSmxznVXvQKVNLDvHU_Ie2A03sWZG_0haCAraXVfx9BPSNHaVYXe-ffSdMpyffG5BEVS-SHt9s-EbGoeVW_Yg9CbYH-jyepZhN5OZQLq4jl4dUJadYt3iOXmkxRey5Nc1tnLjgt-INcxVs45QQEIF7Gx2E-4F8p0ObAJwoTeBR1RtcmwmHypT1nTp32BVFRqIeC-iiyvGVvEQQK4an5gvc1Q31xB23bYtNXTzNYdGnl74KY5vIm7';

  static const String _travelImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBE4kULQ_r_Fx1BMy_Tp1fyYFWwdoytxfpTX_8sDnPbzte6iHa-H6JTcjDTAl1jfrTHyObSQOxR0dZtS-z2Htggs0g1w59NmtJunwuw6bZSzDAGEKiF3LXCXTzMWK00C4wf3P3TFWsoefOi-BmS33rY3pw9Kwwd7zxxDkDyQ2ZmVZOWm1mj7QIl4MPXxkJkc6cXoZpWAN9WX6MYahmWoSEgyUrqesXWX9wNGflSANNaPnwANRoefrQkokBJ2Sxhm7yv9bbawR8e04wQ';

  static String title(dynamic promo, int index) {
    final rawTitle = _readValue(promo, const [
      'title',
      'name',
      'promoTitle',
      'description',
    ]);

    if (rawTitle is String && rawTitle.trim().isNotEmpty) return rawTitle.trim();

    return index.isEven
        ? 'Makan Hemat di Merchant Pilihan'
        : 'Diskon Tiket Pesawat ke Luar Negeri';
  }

  static String badge(dynamic promo, int index) {
    final rawBadge = _readValue(promo, const [
      'badge',
      'tag',
      'category',
      'subtitle',
    ]);

    if (rawBadge is String && rawBadge.trim().isNotEmpty) return rawBadge.trim();

    return index.isEven ? 'Cashback 50%' : 'Travel Deals';
  }

  static String imageUrl(dynamic promo, int index) {
    final rawUrl = _readValue(promo, const [
      'imageUrl',
      'image',
      'bannerUrl',
      'thumbnailUrl',
      'coverUrl',
    ]);

    if (rawUrl is String && rawUrl.trim().isNotEmpty) return rawUrl.trim();

    return index.isEven ? _diningImageUrl : _travelImageUrl;
  }

  static dynamic _readValue(dynamic source, List<String> fields) {
    if (source == null) return null;

    for (final field in fields) {
      try {
        switch (field) {
          case 'title':
            return source.title;
          case 'name':
            return source.name;
          case 'promoTitle':
            return source.promoTitle;
          case 'description':
            return source.description;
          case 'badge':
            return source.badge;
          case 'tag':
            return source.tag;
          case 'category':
            return source.category;
          case 'subtitle':
            return source.subtitle;
          case 'imageUrl':
            return source.imageUrl;
          case 'image':
            return source.image;
          case 'bannerUrl':
            return source.bannerUrl;
          case 'thumbnailUrl':
            return source.thumbnailUrl;
          case 'coverUrl':
            return source.coverUrl;
        }
      } catch (_) {
        continue;
      }
    }

    return null;
  }
}
