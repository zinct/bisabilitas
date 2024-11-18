import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PageService {
  void dictionary(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
    let popupElement = null;

      if (popupElement == null) {
        document.addEventListener('mouseup', handleMouseUp);
      }

      function handleMouseUp(event) {
        console.log("HEHE");
        const selectedText = window.getSelection()?.toString().trim();

        console.log("HEHE", selectedText);
        console.log("pop", popupElement);
        if (popupElement && popupElement.contains(event.target)) {
          return;
        }

        if (selectedText && selectedText.length > 0) {
          showPopup(selectedText, event);
        } else {
          hidePopup();
        }
      }

      function showPopup(word, event) {
        if (popupElement) {
          document.body.removeChild(popupElement);
        }
        popupElement = document.createElement('button');
        popupElement.id = 'kbbi-popup';
        popupElement.textContent = 'Tanya KBBI';
        document.body.appendChild(popupElement);
        applyPopupStyles(popupElement, true);

        const rect = {
          left: event.clientX,
          top: event.clientY,
          bottom: event.clientY,
          right: event.clientX
        };

        positionPopup(popupElement, rect);

        console.log('Popup shown');

        popupElement.addEventListener('click', (e) => {
          e.stopPropagation();
          console.log('Popup clicked');
          transformToDiv(word);
        });
      }

      function transformToDiv(word) {
        if (!popupElement) return;

        console.log('transformToDiv called');

        const divElement = document.createElement('div');
        divElement.id = 'kbbi-popup';
        divElement.textContent = 'Loading...';

        const rect = popupElement.getBoundingClientRect();
        document.body.replaceChild(divElement, popupElement);
        popupElement = divElement;

        applyPopupStyles(divElement, false);
        positionPopup(divElement, rect);

        fetchDefinition(word);
      }

      async function fetchDefinition(word) {
        const res = await axios.post(`http://localhost:5000/api/v1/ai/kbbi`, {
          word: word,
        });
        if (popupElement) {
          popupElement.textContent = res.data.definition;
        }
      }

      function hidePopup() {
        if (popupElement) {
          document.body.removeChild(popupElement);
          popupElement = null;
        }
      }

      function positionPopup(element, rect) {
        const viewportHeight = window.innerHeight;
        const spaceBelow = viewportHeight - rect.bottom;
        const elementHeight = 50; // Estimate height, adjust as needed
        const spacing = 10; // Space between text and popup

        if (spaceBelow >= elementHeight + spacing) {
          // Show below with spacing
          element.style.top = rect.bottom + window.scrollY + spacing + `px`;
        } else {
          // Show above with spacing
          element.style.top = rect.top + window.scrollY - elementHeight - spacing + `px`;
        }

        element.style.left = rect.left + window.scrollX + `px`;
      }

      function applyPopupStyles(element, isButton) {
        element.style.position = 'absolute';
        element.style.backgroundColor = '#3E2723'; // Dark brown background
        element.style.color = 'white'; // White text
        element.style.border = 'none';
        element.style.padding = '10px';
        element.style.borderRadius = '5px';
        element.style.boxShadow = '0 2px 5px rgba(0,0,0,0.3)';
        element.style.zIndex = '1000';
        element.style.maxWidth = isButton ? 'auto' : '300px';
        element.style.fontSize = '14px';
        element.style.fontFamily = 'Arial, sans-serif';

        if (isButton) {
          element.style.cursor = 'pointer';
        } else {
          element.style.minWidth = '200px';
          element.style.minHeight = '50px';
        }
      }
    ''');
  }

  void addNumberToElement(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''
      function addNumbersToElements() {
        clickableElements = Array.from(document.querySelectorAll('a, button'));
        clickableElements.forEach((element, index) => {
          const numberLabel = document.createElement('span');
          numberLabel.textContent = (index + 1).toString();
          numberLabel.setAttribute('data-sound-nav', 'true');
          numberLabel.style.cssText = `
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 2px 5px;
            border-radius: 10px;
            font-size: 12px;
          `;
          element.style.position = 'relative';
          element.appendChild(numberLabel);
        });
      }

      function navigateBrowser(number) {
        if (!isNaN(number) && number > 0 && number <= clickableElements.length) {
            clickableElements[number - 1].click();
        }
      }

    addNumbersToElements();

    ''');
  }

  void removeNumbersFromElements(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: '''

    function removeNumbersFromElements() {
        clickableElements.forEach(element => {
          const numberLabel = element.querySelector('span[data-sound-nav]');
          if (numberLabel) {
            element.removeChild(numberLabel);
          }
        });
        clickableElements = [];
      }
      removeNumbersFromElements();
    ''');
  }

  void navigateWithNumber(InAppWebViewController controller, int number) async {
    await controller.evaluateJavascript(source: '''
    navigateBrowser($number);
  ''');
  }

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
            src: url(data:application/octet-stream;base64,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),
  url(data:application/font-woff;base64,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);
            
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
