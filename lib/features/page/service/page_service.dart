import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PageService {
  void increaseFontSize(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      function increaseFontSize(scaleFactor = 1.2) {
        const elements = document.querySelectorAll('*');
        elements.forEach((element) => {
          const currentFontSize = window.getComputedStyle(element).fontSize;
          const newFontSize = parseFloat(currentFontSize) * scaleFactor;
          element.style.fontSize = newFontSize + 'px';
        });
        localStorage.setItem('fontIncreased', 'true');
      }
      increaseFontSize();
    ''');
  }

  void resetFontSize(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      function resetFontSize() {
        const elements = document.querySelectorAll('*');
        elements.forEach((element) => {
          element.style.fontSize = '';
        });
        localStorage.removeItem('fontIncreased');
      }
      resetFontSize();
    ''');
  }

  void initializeFontSize(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      function initializeFontSize() {
        const fontIncreased = localStorage.getItem('fontIncreased');
        if (fontIncreased === 'true') {
          increaseFontSize();
        }
      }
      initializeFontSize();
    ''');
  }

  void applyContrast(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
        function invertContrast() {
          // Cek apakah sudah ada elemen style dengan id 'invert-style'
          let invertStyle = document.getElementById('invert-style');

          if (invertStyle) {
            // Jika sudah ada, hapus elemen tersebut untuk mengembalikan kontras normal
            invertStyle.remove();
          } else {
            // Jika belum ada, buat elemen style baru untuk membalikkan kontras
            invertStyle = document.createElement('style');
            invertStyle.id = 'invert-style';
            invertStyle.innerHTML = `
              html {
                filter: invert(1) hue-rotate(180deg);
              }
              img, video, canvas, svg {
                filter: invert(1) hue-rotate(180deg);
              }
            `;
            document.head.appendChild(invertStyle);
          }
        }
      invertContrast();
      ''');
  }

  void toggleOpenDyslexicFont(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
    function toggleOpenDyslexicFont() {
      let dyslexicStyle = document.getElementById('open-dyslexic-style');
      if (dyslexicStyle) {
        // Hapus gaya jika font OpenDyslexic sedang aktif
        dyslexicStyle.remove();
        localStorage.removeItem('useOpenDyslexic');
      } else {
        // Tambahkan gaya jika font OpenDyslexic belum aktif
        dyslexicStyle = document.createElement('style');
        dyslexicStyle.id = 'open-dyslexic-style';
        dyslexicStyle.textContent = `
          @font-face {
            font-family: 'OpenDyslexic';
            src: url('https://cdn.jsdelivr.net/npm/open-dyslexic@1.0.3/open-dyslexic-regular.woff2') format('woff2'),
                 url('https://cdn.jsdelivr.net/npm/open-dyslexic@1.0.3/open-dyslexic-regular.woff') format('woff');
            font-style: normal;
            font-weight: normal;
          }
          /* Target all elements aggressively */
          html, body, * {
            font-family: 'OpenDyslexic', Arial, sans-serif !important;
            font-size: inherit !important; /* Maintain original size */
            line-height: 1.4 !important; /* Improve readability for dyslexia */
          }
          /* Specific targets */
          div, p, span, a, li, h1, h2, h3, h4, h5, h6, header, footer, article, section, aside, nav, figure, figcaption, main, mark, time, input, button, select, textarea, label {
            font-family: 'OpenDyslexic', Arial, sans-serif !important;
          }
          /* Overwrite possible inline styles */
          [style*="font-family"] {
            font-family: 'OpenDyslexic', Arial, sans-serif !important;
          }
          /* Additional selectors for specific elements */
          ::placeholder {
            font-family: 'OpenDyslexic', Arial, sans-serif !important;
          }
          input, textarea {
            font-family: 'OpenDyslexic', Arial, sans-serif !important;
          }
        `;
        document.head.appendChild(dyslexicStyle);

        // Apply font to all elements directly
        const elements = document.querySelectorAll('*');
        elements.forEach((element) => {
          // Overwrite inline styles if present
          element.style.fontFamily = "'OpenDyslexic', Arial, sans-serif !important";
        });

        localStorage.setItem('useOpenDyslexic', 'true');
      }
    }
    toggleOpenDyslexicFont();
  ''');
  }

  void initializeOpenDyslexicFont(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      function initializeOpenDyslexicFont() {
        const useOpenDyslexic = localStorage.getItem('useOpenDyslexic');
        if (useOpenDyslexic === 'true') {
          toggleOpenDyslexicFont();
        }
      }
      initializeOpenDyslexicFont();
    ''');
  }

  void toggleSaturation(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
    // Variabel untuk melacak langkah saat ini
    if (typeof saturationStep === 'undefined') {
      saturationStep = 1;
    }

    function toggleSaturation() {
      // Ambil elemen body atau elemen utama lainnya
      const body = document.body;

      // Reset semua filter terlebih dahulu
      body.style.filter = '';

      // Periksa langkah saturasi dan terapkan perubahan
      switch (saturationStep) {
        case 0:
          // Langkah 0: Default (tidak ada perubahan)
          break;
        case 1:
          // Langkah 1: Low Saturation (saturasi rendah)
          body.style.filter = 'saturate(50%)';
          break;
        case 2:
          // Langkah 2: High Saturation (saturasi tinggi)
          body.style.filter = 'saturate(200%)';
          break;
        case 3:
          // Langkah 3: Desaturate (saturasi nol / grayscale)
          body.style.filter = 'saturate(0%)';
          break;
      }

      // Tingkatkan langkah atau reset jika sudah mencapai maksimum
      saturationStep = (saturationStep + 1) % 4;
    }

    // Panggil fungsi untuk toggle saturasi
    toggleSaturation();
  ''');
  }

  void toggleLineSpacing(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      (function() {
        let lineSpacingStep = window.lineSpacingStep || 0; // Default ke 0 jika belum diatur

        lineSpacingStep = (lineSpacingStep + 1) % 3; // Meningkatkan langkah dan reset setelah 2
        window.lineSpacingStep = lineSpacingStep; // Simpan nilai di window untuk penggunaan berikutnya

        let lineHeightValue;

        switch(lineSpacingStep) {
          case 0: // Default
            lineHeightValue = 'normal';
            break;
          case 1: // Low
            lineHeightValue = '1.5'; // Sesuaikan nilai untuk efek "Low"
            break;
          case 2: // High
            lineHeightValue = '2'; // Sesuaikan nilai untuk efek "High"
            break;
          default:
            lineHeightValue = 'normal';
        }

        // Terapkan gaya line-height ke semua elemen teks
        document.querySelectorAll('*').forEach((element) => {
          element.style.lineHeight = lineHeightValue;
        });
      })();
    ''');
  }

  void toggleLetterSpacing(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
    (function() {
        // Ambil langkah letter-spacing dari localStorage
        let letterSpacingStep = parseInt(localStorage.getItem('letterSpacingStep')) || 0;

        // Meningkatkan langkah dan reset setelah 2
        letterSpacingStep = (letterSpacingStep + 1) % 3;

        let letterSpacingValue;

        // Tentukan nilai letter-spacing berdasarkan langkah saat ini
        switch(letterSpacingStep) {
            case 0: // Default
                letterSpacingValue = 'normal';
                break;
            case 1: // Low
                letterSpacingValue = '1px'; // Sesuaikan nilai untuk efek "Low"
                break;
            case 2: // High
                letterSpacingValue = '2px'; // Sesuaikan nilai untuk efek "High"
                break;
            default:
                letterSpacingValue = 'normal';
        }

        // Terapkan gaya letter-spacing ke semua elemen teks
        document.querySelectorAll('*').forEach((element) => {
            element.style.letterSpacing = letterSpacingValue;
        });

        // Simpan langkah saat ini di localStorage
        localStorage.setItem('letterSpacingStep', letterSpacingStep);
    })();
  ''');
  }

  void toggleFontSize(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
    function toggleFontSize() {
        // Ambil langkah font-size dari localStorage atau default ke 0
        let fontSizeStep = parseInt(localStorage.getItem('fontSizeStep')) || 0;

        // Meningkatkan langkah dan reset setelah 2
        fontSizeStep = (fontSizeStep + 1) % 3;

        let fontSizeValue;

        // Tentukan ukuran font berdasarkan langkah saat ini
        switch(fontSizeStep) {
            case 0: // Default
                fontSizeValue = 'initial'; // Ukuran font default
                break;
            case 1: // Low
                fontSizeValue = '102%'; // 20% lebih besar dari default
                break;
            case 2: // High
                fontSizeValue = '103%'; // 50% lebih besar dari default
                break;
            default:
                fontSizeValue = 'initial';
        }

        // Terapkan gaya font-size ke semua elemen teks
        document.querySelectorAll('*').forEach((element) => {
            // Terapkan ukuran font relatif
            element.style.fontSize = fontSizeValue;
        });

        // Simpan langkah saat ini di localStorage
        localStorage.setItem('fontSizeStep', fontSizeStep);
    }

    // Contoh penggunaan (misalnya saat tombol diklik)
    toggleFontSize();
  ''');
  }

  void toggleTextAlign(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
    function toggleTextAlign() {
      // Ambil langkah text-align dari localStorage atau default ke 0
      let textAlignStep = parseInt(localStorage.getItem('textAlignStep')) || 0;

      // Meningkatkan langkah dan reset setelah 3
      textAlignStep = (textAlignStep + 1) % 4;

      let textAlignValue;

      // Tentukan alignment teks berdasarkan langkah saat ini
      switch(textAlignStep) {
          case 0: // Default
              textAlignValue = ''; // Biarkan ukuran teks default (tidak ada perubahan)
              break;
          case 1: // Left Align
              textAlignValue = 'left'; // Rata kiri
              break;
          case 2: // Center Align
              textAlignValue = 'center'; // Rata tengah
              break;
          case 3: // Right Align
              textAlignValue = 'right'; // Rata kanan
              break;
          default:
              textAlignValue = '';
      }

      // Terapkan gaya text-align ke semua elemen teks
      document.querySelectorAll('*').forEach((element) => {
          // Terapkan alignment teks
          element.style.textAlign = textAlignValue;
      });

      // Simpan langkah saat ini di localStorage
      localStorage.setItem('textAlignStep', textAlignStep);
  }

  // Contoh penggunaan (misalnya saat tombol diklik)
  toggleTextAlign();
  ''');
  }
}
