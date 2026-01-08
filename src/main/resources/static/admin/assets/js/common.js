

$(document).ready(function () {
  $('.gnb .dep-01').click(function () {
    if ($('.gnb').hasClass('active')) {
      $('.gnb').removeClass('active');
    }//23.03.23
    // $(this).closest('li').toggleClass('on').find('.dep-02').slideToggle(600).closest('li').siblings().removeClass('on').find('.dep-02').slideUp(600).find('li').removeClass('on');
    $(this).closest('li').toggleClass('on').find('.dep-02').stop().slideToggle(600).closest('li').siblings().removeClass('on').find('.dep-02').stop().slideUp(600).find('li').removeClass('on');
  })

  $('.gnb .dep-02 li').click(function () {
    $(this).addClass('on').siblings().removeClass('on').closest('.dep-02').parent('li').siblings().find('.dep-02 li').removeClass('on');
  });


  // 셀렉트
  $('.select').click(function () {
    $(this).toggleClass('on').closest('.select-box').find('.option').slideToggle(200);
  });

  $('.option li').click(function () {
    let txt = $(this).text();
    $(this).closest('.select-box').find($(".select")).text(txt);
    $(this).closest('.select-box').find($("input")).val(txt);

  });

  $('.seq li').click(function () {
    let data_val = $(this).data('val');
    let txt = $(this).text();
    $(this).closest('.select-box').find($(".select")).text(txt);
    $(this).closest('.select-box').find('input').val(data_val);
  });

  $('.pagination a').click(function () {

    $(this).addClass('on').siblings().removeClass('on');
  });


  // 닫기
  $(document).click(function (e) {
    let tg = e.target.className;
    let _select = tg.indexOf('select');


    if (_select < 0) {
      $('.option').slideUp(200);
      $('.select').removeClass('on');
    }
  });



  //파일 첨부

  let file = false;

  $(document).on('click', 'input[type="file"]', function () {
    if (file === false) {
      return false;
    } else {
      file = false;
    }
  })

  $(document).on('click', '.file-btn', function () {
    file = true;
    if (file === true) {
      $(this).closest('.file-box').find("[type='file']").trigger('click');
    }
  })


  let file_box = ""
  file_box += '<div class="file-box"' + '>';
  file_box += '<input class="mr-5 flex-1" id="File" type="file"' + '>';
  file_box += '<button class="btn file-btn table-btn bg-purple" type="button"' + '>' + '파일찾기' + '</button>';
  file_box += '<button class="btn d-none del-btn table-btn bg-deepgray" type="button"' + '>' + '삭제' + '</button>';
  file_box += '</div>';


  $('.file-add').on('click', function () {
    $('.file-wrap').append(file_box);
    $('.del-btn').removeClass('d-none');
  });
  
  $(document).ready(function () {
    // 등록 페이지 초기 상태: 숨김 처리
    if (!$('.attach-file-wrap').find('.attach-file').text().trim()) {
        $('.attach-file-wrap').hide(); // 파일명 없는 경우 숨김
    }

    // 파일 선택 시 표시 처리
    $(document).on('change', '#thumbfile', function () {
        const fileInput = $(this);
        const fileName = fileInput.val().split('\\').pop(); // 파일명 추출
        const fileWrap = fileInput.closest('.file-wrap');
        const attachFileWrap = fileWrap.find('.attach-file-wrap');
        const fileNameDisplay = attachFileWrap.find('.attach-file');
        const previewImage = $('#preview-thumb');

        if (fileName) {
            fileNameDisplay.text(fileName); // 파일명 표시
            attachFileWrap.show(); // .attach-file-wrap 보이기
            attachFileWrap.find('.attach-file-del2').show(); // 삭제 버튼 보이기
            previewImage.attr('src', '/path/to/preview/image'); // 미리보기 이미지 설정
        } else {
            attachFileWrap.hide(); // .attach-file-wrap 숨김
            previewImage.attr('src', '/static/admin/assets/img/icon/null.jpg'); // 기본 이미지
        }
    });
    // 파일 선택 시 표시 처리
    $(document).on('change', '#thumbfile2', function () {
        const fileInput = $(this);
        const fileName = fileInput.val().split('\\').pop(); // 파일명 추출
        const fileWrap = fileInput.closest('.file-wrap');
        const attachFileWrap = fileWrap.find('.attach-file-wrap');
        const fileNameDisplay = attachFileWrap.find('.attach-file');
        const previewImage = $('#preview-thumb2');

        if (fileName) {
            fileNameDisplay.text(fileName); // 파일명 표시
            attachFileWrap.show(); // .attach-file-wrap 보이기
            attachFileWrap.find('.attach-file-del2').show(); // 삭제 버튼 보이기
            previewImage.attr('src', '/path/to/preview/image'); // 미리보기 이미지 설정
        } else {
            attachFileWrap.hide(); // .attach-file-wrap 숨김
            previewImage.attr('src', '/static/admin/assets/img/icon/null.jpg'); // 기본 이미지
        }
    });
    // 파일 선택 시 표시 처리
    $(document).on('change', '#thumbfile3', function () {
        const fileInput = $(this);
        const fileName = fileInput.val().split('\\').pop(); // 파일명 추출
        const fileWrap = fileInput.closest('.file-wrap');
        const attachFileWrap = fileWrap.find('.attach-file-wrap');
        const fileNameDisplay = attachFileWrap.find('.attach-file');
        const previewImage = $('#preview-thumb3');

        if (fileName) {
            fileNameDisplay.text(fileName); // 파일명 표시
            attachFileWrap.show(); // .attach-file-wrap 보이기
            attachFileWrap.find('.attach-file-del2').show(); // 삭제 버튼 보이기
            previewImage.attr('src', '/path/to/preview/image'); // 미리보기 이미지 설정
        } else {
            attachFileWrap.hide(); // .attach-file-wrap 숨김
            previewImage.attr('src', '/static/admin/assets/img/icon/null.jpg'); // 기본 이미지
        }
    });
    // 파일 선택 시 표시 처리
    $(document).on('change', '#thumbfile4', function () {
        const fileInput = $(this);
        const fileName = fileInput.val().split('\\').pop(); // 파일명 추출
        const fileWrap = fileInput.closest('.file-wrap');
        const attachFileWrap = fileWrap.find('.attach-file-wrap');
        const fileNameDisplay = attachFileWrap.find('.attach-file');
        const previewImage = $('#preview-thumb4');

        if (fileName) {
            fileNameDisplay.text(fileName); // 파일명 표시
            attachFileWrap.show(); // .attach-file-wrap 보이기
            attachFileWrap.find('.attach-file-del2').show(); // 삭제 버튼 보이기
            previewImage.attr('src', '/path/to/preview/image'); // 미리보기 이미지 설정
        } else {
            attachFileWrap.hide(); // .attach-file-wrap 숨김
            previewImage.attr('src', '/static/admin/assets/img/icon/null.jpg'); // 기본 이미지
        }
    });
    // 파일 선택 시 표시 처리
    $(document).on('change', '#thumbfile5', function () {
        const fileInput = $(this);
        const fileName = fileInput.val().split('\\').pop(); // 파일명 추출
        const fileWrap = fileInput.closest('.file-wrap');
        const attachFileWrap = fileWrap.find('.attach-file-wrap');
        const fileNameDisplay = attachFileWrap.find('.attach-file');
        const previewImage = $('#preview-thumb5');

        if (fileName) {
            fileNameDisplay.text(fileName); // 파일명 표시
            attachFileWrap.show(); // .attach-file-wrap 보이기
            attachFileWrap.find('.attach-file-del2').show(); // 삭제 버튼 보이기
            previewImage.attr('src', '/path/to/preview/image'); // 미리보기 이미지 설정
        } else {
            attachFileWrap.hide(); // .attach-file-wrap 숨김
            previewImage.attr('src', '/static/admin/assets/img/icon/null.jpg'); // 기본 이미지
        }
    });
    // 파일 선택 시 표시 처리
    $(document).on('change', '#thumbfile6', function () {
        const fileInput = $(this);
        const fileName = fileInput.val().split('\\').pop(); // 파일명 추출
        const fileWrap = fileInput.closest('.file-wrap');
        const attachFileWrap = fileWrap.find('.attach-file-wrap');
        const fileNameDisplay = attachFileWrap.find('.attach-file');
        const previewImage = $('#preview-thumb6');

        if (fileName) {
            fileNameDisplay.text(fileName); // 파일명 표시
            attachFileWrap.show(); // .attach-file-wrap 보이기
            attachFileWrap.find('.attach-file-del2').show(); // 삭제 버튼 보이기
            previewImage.attr('src', '/path/to/preview/image'); // 미리보기 이미지 설정
        } else {
            attachFileWrap.hide(); // .attach-file-wrap 숨김
            previewImage.attr('src', '/static/admin/assets/img/icon/null.jpg'); // 기본 이미지
        }
    });

    // 파일 삭제 버튼 처리
    $(document).on('click', '.attach-file-del2', function () {
        const parentWrap = $(this).closest('.file-wrap');
        const fileInput = parentWrap.find('input[type="file"]');
        const fileNameDisplay = parentWrap.find('.attach-file');
        const previewImage = $('#preview-thumb');
        const attachFileWrap = parentWrap.find('.attach-file-wrap');

        // 초기화
        fileInput.val(''); // 파일 입력 필드 초기화
        fileNameDisplay.text(''); // 파일명 초기화
        previewImage.attr('src', '/static/admin/assets/img/icon/null.jpg'); // 기본 이미지 초기화

        // 파일명 숨기기
        attachFileWrap.hide(); // 파일명 영역 숨김
        attachFileWrap.find('.attach-file-del2').hide(); // 삭제 버튼 숨기기
        });
    });
  
  const MAX_FILE_SIZE = 2 * 1024 * 1024; // 2MB
  function checkFileSize(input) {
    if (input.files[0].size > MAX_FILE_SIZE) {
      alert('이미지의 크기는 2MB를 초과할 수 없습니다.');
      input.value = ''; // 파일 입력 초기화
      return false;
    }
    return true;
  }

  function readURL(input, previewId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $(`#${previewId}`).attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        $(`#${previewId}`).attr('src', "/static/admin/assets/img/icon/null.jpg");
    }
  }

  $(document).on('change', '#Thumb', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-thumb');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '#thumbfile', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-thumb');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '#productImg', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-productImg');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '#productImg2', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-productImg2');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '#productImg3', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-productImg3');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '#productImg4', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-productImg4');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '#productImg5', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-productImg5');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '#productImg6', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-productImg6');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '#productImg7', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-productImg7');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '#productImg8', function () {
    if (checkFileSize(this)) {
      readURL(this, 'preview-productImg8');
      let fileName = $(this).val().split('\\').pop();
      $(this).closest('.file-wrap').find('.attach-file').text(fileName);
    }
  });
  
  $(document).on('change', '[id^=Thumb]', function () {
    if (checkFileSize(this)) {
        const parentWrap = $(this).closest('.file-wrap');
        const previewId = 'preview-' + this.id.toLowerCase();
        readURL(this, previewId);

        let fileName = $(this).val().split('\\').pop();
        parentWrap.find('.attach-file').text(fileName); // attach-file에 파일명 표시
        parentWrap.find('input[type="text"]').val(fileName); // 텍스트 입력 필드에 파일명 표시

        parentWrap.find('.attach-file-del').show(); // 삭제 버튼 보이기
        parentWrap.find('.file-btn').hide(); // 파일 찾기 버튼 숨기기
        $(this).hide(); // 파일 추가 버튼 숨기기
    }
  });
  
//  $(document).on('click', '.attach-file-del', function () {
//    const parentWrap = $(this).closest('.file-wrap');
//    const fileInput = parentWrap.find('input[type="file"]');
//    const fileNameDisplay = parentWrap.find('.attach-file');
//    const textInput = parentWrap.find('input[type="text"]');
//
//    // 파일 입력 필드 및 파일명 표시 영역 초기화
//    fileInput.val(''); // 파일 입력 필드 초기화
//    fileNameDisplay.text(''); // attach-file에 표시된 파일명 초기화
//    textInput.val(''); // 텍스트 입력 필드(파일명 표시) 초기화
//
//    // 미리보기 이미지 초기화
//    const thumbInputId = fileInput.attr('id');
//    const previewId = 'preview-' + thumbInputId.toLowerCase();
//    $('#' + previewId).attr('src', '/static/admin/assets/img/icon/null.jpg');
//
//    // 삭제 버튼 숨기기 및 파일 추가 버튼 보이기
//    $(this).hide(); // 현재 삭제 버튼 숨기기
//    parentWrap.find('.file-btn').show(); // 파일 찾기 버튼 보이기
//    fileInput.show(); // 파일 입력 필드 보이기
//  });
  
  $('.thumb-add').click(function () {
    if ($(this).closest('.file-box').find('input').val() !== "") {
      let file = $('#Thumb-Img').val();
      $('.attach-file-wrap .attach-file').text(file.substring(file.lastIndexOf("\\") + 1));
    } else {
      alert("추가되는 이미지가 없습니다.");
    }
  });
  
  $(document).on('click', '.attach-img-del', function () {
    $(this).closest('li').remove();
  });
  
  //이미지 폼 클릭 불가
  $('input[type="image"]').click(function () {
    return false;
  }); //240724
  
  function validateImageSize(fileInputId, requiredWidth, requiredHeight = null) {
        const input = document.getElementById(fileInputId);
        if (!input || input.files.length === 0) return;
    
        const file = input.files[0];
        const img = new Image();
    
        img.onload = function () {
            const width = img.width;
            const height = img.height;
    
            let isValid = true;
    
            if (requiredHeight === null) {
                if (width !== requiredWidth) {
                    alert(`가로 사이즈는 ${requiredWidth}px 이어야 합니다.`);
                    isValid = false;
                }
            } else {
                if (width !== requiredWidth || height !== requiredHeight) {
                    alert(`이미지 사이즈는 ${requiredWidth} * ${requiredHeight}px 이어야 합니다.`);
                    isValid = false;
                }
            }
    
            if (!isValid) {
                input.value = '';
            
                const previewId = 'preview-' + fileInputId;
                const preview = document.getElementById(previewId);
                if (preview) {
                    preview.setAttribute('src', '');
                    setTimeout(() => {
                        preview.setAttribute('src', '/static/admin/assets/img/icon/null.jpg');
                    }, 10);
                }
            }
        };
    
        img.onerror = function () {
            alert(`이미지 파일이 아닙니다.`);
            input.value = '';
    
            const previewId = 'preview-' + fileInputId;
            const preview = document.getElementById(previewId);
            if (preview) {
                preview.src = '/static/admin/assets/img/icon/null.jpg';
            }
        };
    
        img.src = URL.createObjectURL(file);
    }

    // 공지사항 썸네일 이미지 (506x285)
    $('.notice-thumb').on('change', function () {
        validateImageSize(this.id, 506, 285);
    });
    // 슬라이드 이미지 1~5 (614x498)
//    ['productImg', 'productImg2', 'productImg3', 'productImg4', 'productImg5'].forEach(function(id) {
//        document.getElementById(id).addEventListener('change', function () {
//            validateImageSize(id, 614, 498);
//        });
//    });
    
    // 기타 이미지 1~3 (가로 960px만)
    // ['productImg5', 'productImg7', 'productImg8'].forEach(function(id) {
    //     document.getElementById(id).addEventListener('change', function () {
    //         validateImageSize(id, 960, null);
    //     });
    // });

  /**
   * =======================================================================================================================================
   * ## 모달
   * =======================================================================================================================================
   */
  $('.modal-open-btn').click(function () {
    let modal_Id = $(this).attr('data-id');
    let modal_type = $(this).attr('data-seq');

    if (modal_type == undefined) {
      $("#modalAdd").css("display", "block");
      $("#modalMody").css("display", "none");
    } else {
      $("#modalAdd").css("display", "none");
      $("#modalMody").css("display", "block");
    }

    $('.modal-wrap').removeClass('d-none');
    $('#' + modal_Id).removeClass('d-none');
    $('.site-wrap, body').addClass('fixed');
  });

  $('.modal-close').click(function(){
    $('.modal-wrap').addClass('d-none');
    $('.modal').addClass('d-none');
    $('.site-wrap, body').removeClass('fixed');
    $('.day-wrap .date').removeClass('on');
  });

  $('.modal-sub-open').click(function(){
    $('.modal-sub').removeClass('d-none');
  });//22.09.02

  $('.modal-sub-close').click(function(){
    $(this).closest('.modal-sub').addClass('d-none');
  });


  //서브 인풋 박스 추가

  let sub_menu = ""
  sub_menu += '<div class="input-box sub-menu">';
  sub_menu += '<label class="label">' + "메뉴명 :" + ' </label>';
  sub_menu += '<div class="flex-1 flex-start">';
  sub_menu += '<input class="wid-180 mr-5" type="text">';
  sub_menu += '<input class="flex-1" type="text" placeholder="url">';
  sub_menu += '<a class="btn del-btn table-btn bg-deepgray" href="#n">' + '삭제' + '</a>';
  sub_menu += '</div>';
  sub_menu += '</div>';


  let Max = 6;
  $(document).on('click', '.input-add', function () {
    let item = $(this).closest('.modal-body').find('.input-box').length;

    if (item < Max) {
      $('.modal-body').append(sub_menu);
    } else if (item >= Max) {
      alert('하위 메뉴는 ' + Max + '개 까지만 추가 가능합니다.');
    }
  });


  //삭제
  $(document).on('click', '.del-btn', function () {
    if ($(this).closest('.file-box')) {
      $(this).closest('.file-box').remove();
    }
    if ($(this).closest('.sub-menu')) {
      $(this).closest('.sub-menu').remove();
    }
  })


  //모달 닫기

  $('.modal-close').click(function () {
    $(this).closest('.modal').addClass('d-none').closest('.modal-wrap').addClass('d-none');
  });



  //글수정

  $('.mody-btn').click(function () {
    $(this).prev().removeAttr("readonly");
  })

  $('.file-mody-btn').click(function () {
    if (!$(this).hasClass('click')) {
      $(this).addClass('click').parent().find('input').toggleClass('d-none');

      $(this).text('수정취소');
      file = true;
      if (file === true) {
        $("[type='file']").trigger('click');
      }
    } else if ($(this).hasClass('click')) {
      $(this).removeClass('click').parent().find('input').toggleClass('d-none');
      $(this).text('수정');
      $(this).parent().find('input[type="file').val('');
      file = false;
    }
  })


  //탭 23.11.03

  $('.tap a').click(function(){
    let id = $(this).attr('data-id');

    $('.tab_li').removeClass('active');
    $(this).parent().addClass('active');

    $('.langPanel').addClass('d-none');
    $('#'+id).removeClass('d-none');
    //$(id).removeClass('d-none').siblings().addClass('d-none');
  })
  
  //제품 설명 라인 추가 250113
    let desc_max = 10;

    $(document).on('click', '.desc-add', function () {
        let currentIds = [];
        
        $('.desc-wrap input[id^="modelDesc"]').each(function () {
            let idNumber = parseInt($(this).attr('id').replace('modelDesc', ''));
            currentIds.push(idNumber);
        });
    
        let nextId = 1;
        for (let i = 1; i <= desc_max; i++) {
            if (!currentIds.includes(i)) {
                nextId = i;
                break;
            }
        }
    
        if (currentIds.length < desc_max) {
            let desc = `
            <div class="input-wrap">
                <input id="modelDesc${nextId}" name="modelDesc${nextId}" maxlength="84" placeholder="내용을 입력해주세요.">
                <div class="btn-wrap">
                    <button class="btn desc-add" type="button">+</button>
                    <button class="btn desc-del" type="button">-</button>
                </div>
            </div>`;
    
            $('.desc-add').hide();
            $('.desc-wrap').append(desc);
        } else {
            alert('최대 ' + desc_max + '개까지만 추가할 수 있습니다.');
        }
    });
    
    // 제품 설명 라인 삭제
    $(document).on('click', '.desc-del', function () {
        $(this).closest('.input-wrap').remove();
    
        $('.desc-wrap .input-wrap:last-child').find('.desc-add').show();
    });

});