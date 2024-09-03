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

  void toggleInvertColor(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
    function toggleInvertColors() {
        // Cek apakah style element untuk invert color sudah ada
        let invertStyle = document.getElementById('invert-colors-style');
        
        if (invertStyle) {
            // Jika sudah ada, hapus elemen style tersebut (reset ke warna normal)
            invertStyle.remove();
            localStorage.removeItem('invertColorsEnabled');
        } else {
            // Jika belum ada, buat elemen style baru untuk invert color
            invertStyle = document.createElement('style');
            invertStyle.id = 'invert-colors-style';
            invertStyle.textContent = `
                html {
                    filter: invert(1) hue-rotate(180deg);
                    background-color: black;
                }
                img, video, svg, iframe, picture, object, embed {
                    filter: invert(1) hue-rotate(180deg) !important;
                }
            `;
            document.head.appendChild(invertStyle);
            localStorage.setItem('invertColorsEnabled', 'true');
        }
    }

    // Contoh penggunaan (misalnya saat tombol diklik)
    toggleInvertColors();
  ''');
  }

  void toggleCaption(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      function toggleImageTooltips() {
        // Cek apakah tooltip sudah ada di halaman
        let tooltipsExist = document.querySelector('.image-tooltip') !== null;

        if (tooltipsExist) {
          // Jika tooltip ada, hapus semua
          document.querySelectorAll('.image-tooltip').forEach((tooltip) => tooltip.remove());
        } else {
          // Jika tidak ada tooltip, tambahkan tooltips
          const images = document.querySelectorAll('img');

          images.forEach((img) => {
            const tooltipText = img.alt || img.getAttribute('data-title') || 'No description available';

            const tooltip = document.createElement('span');
            tooltip.className = 'image-tooltip';
            tooltip.textContent = tooltipText;

            img.parentElement.style.position = 'relative';
            img.parentElement.appendChild(tooltip);

            tooltip.style.display = 'block';
          });
        }
      }

      // Panggil fungsi toggle saat halaman dimuat atau tombol diklik
      toggleImageTooltips();
  ''');
  }

  void toggleBlockImage(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      function toggleImageBlockingWithObserver() {
        // Cek apakah gambar telah diblokir
        const imagesBlocked = localStorage.getItem('imagesBlockedObserver') === 'true';

        if (imagesBlocked) {
          // Jika gambar diblokir, kembalikan gambar
          document.querySelectorAll('img[data-original-src]').forEach((img) => {
            img.src = img.getAttribute('data-original-src');
            img.removeAttribute('data-original-src');
            img.style.display = ''; // Kembalikan gaya display asli
          });

          // Kembalikan latar belakang elemen yang sebelumnya berisi gambar
          document.querySelectorAll('[data-original-bg]').forEach((element) => {
            element.style.backgroundImage = element.getAttribute('data-original-bg');
            element.removeAttribute('data-original-bg');
          });

          // Hentikan dan hapus observer
          if (window.imageBlockObserver) {
            window.imageBlockObserver.disconnect();
            window.imageBlockObserver = null;
          }

          // Hapus tanda bahwa gambar diblokir
          localStorage.removeItem('imagesBlockedObserver');
        } else {
          // Fungsi untuk memblokir gambar
          function blockImages() {
            document.querySelectorAll('img').forEach((img) => {
              if (!img.hasAttribute('data-original-src')) {
                img.setAttribute('data-original-src', img.src);
                img.src = ''; // Blokir gambar dengan mengosongkan src
                img.style.display = 'none'; // Hapus gambar secara visual dari halaman
              }
            });

            // Blokir latar belakang elemen yang berisi gambar
            document.querySelectorAll('*').forEach((element) => {
              const bgImage = window.getComputedStyle(element).backgroundImage;
              if (bgImage && bgImage !== 'none' && !element.hasAttribute('data-original-bg')) {
                element.setAttribute('data-original-bg', bgImage);
                element.style.backgroundImage = 'none'; // Hapus gambar latar belakang
              }
            });
          }

          // Blokir gambar yang ada saat ini
          blockImages();

          // Buat observer untuk memonitor perubahan pada DOM
          window.imageBlockObserver = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
              if (mutation.addedNodes.length > 0) {
                blockImages();
              }
            });
          });

          // Mulai observer pada seluruh dokumen
          window.imageBlockObserver.observe(document.body, {
            childList: true,
            subtree: true,
          });

          // Tandai bahwa gambar telah diblokir
          localStorage.setItem('imagesBlockedObserver', 'true');
        }
      }

      // Panggil fungsi toggle
      toggleImageBlockingWithObserver();
      ''');
  }

  void initialCaption(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
        (function() {
            const style = document.createElement('style');
            style.textContent = \`
              .image-tooltip {
                display: block;
                position: absolute;
                background-color: rgba(0, 0, 0, 0.7);
                color: #fff;
                padding: 5px;
                border-radius: 5px;
                font-size: 12px;
                max-width: 200px;
                text-align: center;
                z-index: 1000;
                top: 100%;
                left: 50%;
                transform: translateX(-50%);
                margin-top: 5px;
              }

              img {
                display: inline-block;
                position: relative;
              }
            \`;
            document.head.appendChild(style);
          })();
  ''');
  }

  void toggleSpotFocus(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      function toggleSpotFocus() {
        // Cek apakah mode fokus sudah aktif
        const spotFocusEnabled = document.getElementById('spot-focus-overlay');

        if (spotFocusEnabled) {
          // Jika aktif, hapus elemen overlay
          document.getElementById('spot-focus-overlay').remove();
          localStorage.removeItem('spotFocusEnabled');
        } else {
          // Jika tidak aktif, buat dan tambahkan elemen overlay ke body
          const overlay = document.createElement('div');
          overlay.id = 'spot-focus-overlay';
          overlay.style.position = 'fixed';
          overlay.style.top = '0';
          overlay.style.left = '0';
          overlay.style.width = '100%';
          overlay.style.height = '100%';
          overlay.style.backgroundColor = 'rgba(0, 0, 0, 0)'; // Layar menjadi gelap
          overlay.style.pointerEvents = 'none'; // Jangan ganggu interaksi pengguna di elemen lain
          overlay.style.zIndex = '9999'; // Pastikan overlay berada di atas semua elemen lainnya

          // Tambahkan elemen fokus persegi panjang
          const focusArea = document.createElement('div');
          focusArea.id = 'focus-area';
          focusArea.style.position = 'absolute';
          focusArea.style.width = '300px'; // Lebar fokus area
          focusArea.style.height = '150px'; // Tinggi fokus area
          focusArea.style.backgroundColor = 'transparent'; // Area fokus transparan
          focusArea.style.boxShadow = '0 0 0 9999px rgba(0, 0, 0, 0.9)'; // Buat layar di luar area fokus menjadi gelap
          focusArea.style.borderRadius = '10px'; // Opsi untuk memberikan border-radius
          focusArea.style.pointerEvents = 'auto';

          // Tambahkan elemen fokus ke overlay
          overlay.appendChild(focusArea);
          document.body.appendChild(overlay);

          // Simpan status fokus di localStorage
          localStorage.setItem('spotFocusEnabled', 'true');

          // Update posisi area fokus saat kursor bergerak
          document.addEventListener('mousemove', updateFocusAreaPosition);

          // Fungsi untuk memperbarui posisi area fokus
          function updateFocusAreaPosition(event) {
            const x = event.clientX - (focusArea.offsetWidth / 2);
            const y = event.clientY - (focusArea.offsetHeight / 2);
            focusArea.style.left = x + `px`;
            focusArea.style.top = y + `px`;
          }
        }
      }

      // Panggil fungsi toggle saat diaktifkan
      toggleSpotFocus();
  ''');
  }

  void toggleReading(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      function toggleReadingFocus() {
        const focusEnabled = document.getElementById('reading-focus-overlay');

        if (focusEnabled) {
          // Jika aktif, hapus elemen overlay
          document.getElementById('reading-focus-overlay').remove();
          localStorage.removeItem('readingFocusEnabled');
        } else {
          // Jika tidak aktif, buat dan tambahkan elemen overlay ke body
          const overlay = document.createElement('div');
          overlay.id = 'reading-focus-overlay';
          overlay.style.position = 'fixed';
          overlay.style.top = '0';
          overlay.style.left = '0';
          overlay.style.width = '100%';
          overlay.style.height = '100%';
          overlay.style.backgroundColor = 'white'; // Latar belakang putih
          overlay.style.color = 'black'; // Warna teks hitam untuk kontras yang baik
          overlay.style.zIndex = '9999'; // Pastikan overlay berada di atas semua elemen lainnya
          overlay.style.overflow = 'auto'; // Biarkan scroll jika konten lebih tinggi dari layar

          // Hapus semua elemen non-teks
          const allElements = document.querySelectorAll('*');
          allElements.forEach((element) => {
            const tagName = element.tagName.toLowerCase();
            if (['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'span', 'a', 'li', 'div'].includes(tagName)) {
              element.style.display = 'block'; // Tampilkan elemen teks
              element.style.margin = '0'; // Hapus margin untuk elemen teks
              element.style.padding = '0'; // Hapus padding untuk elemen teks
            } else {
              element.style.display = 'none'; // Sembunyikan elemen non-teks
            }
          });

          // Buat kontainer untuk teks
          const textContainer = document.createElement('div');
          textContainer.id = 'text-container';
          textContainer.style.padding = '20px'; // Padding untuk kontainer teks

          // Salin teks dari elemen yang tersisa ke kontainer
          const textElements = document.querySelectorAll('p, h1, h2, h3, h4, h5, h6, span, a, li, div');
          textElements.forEach((element) => {
            const clonedElement = element.cloneNode(true);
            textContainer.appendChild(clonedElement);
          });

          // Tambahkan kontainer teks ke overlay
          overlay.appendChild(textContainer);
          document.body.appendChild(overlay);

          // Simpan status fokus membaca di localStorage
          localStorage.setItem('readingFocusEnabled', 'true');
        }
      }

      // Panggil fungsi toggle saat diaktifkan
      toggleReadingFocus();
  ''');
  }
}
