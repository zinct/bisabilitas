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
          dyslexicStyle.remove();
          localStorage.removeItem('useOpenDyslexic');
        } else {
          dyslexicStyle = document.createElement('style');
          dyslexicStyle.id = 'open-dyslexic-style';
          dyslexicStyle.textContent = `
            @font-face {
              font-family: 'OpenDyslexic';
              src: url('https://cdn.jsdelivr.net/npm/open-dyslexic@1.0.3/open-dyslexic-regular.woff') format('woff');
              font-style: normal;
              font-weight: normal;
            }
            * {
              font-family: 'OpenDyslexic', sans-serif !important;
            }
          `;
          document.head.appendChild(dyslexicStyle);
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
}
