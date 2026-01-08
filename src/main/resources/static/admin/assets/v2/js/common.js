$(document).ready(function() {

    // 셀렉트
    $('.select').click(function() {
        $('.select').not($(this)).removeClass('on');
        $(this).toggleClass('on');
    });

    $('option').click(function() {
        $(this).closest('.select').toggleClass('on');
    });


    //메뉴 관리 - 추가
    (function() {
        let depth = 0;

        //메뉴 등록 버튼
        $('.menu-add-btn').click(function() {
            let wrap = $('.table-wrap');
            let body = wrap.eq(depth).find('tbody');
            let menuName = $('#menu_name').val();
            let tr;
            tr += '<tr>';
            tr += '<td>';
            tr += '<div class="visible-f">사용</div>';
            tr += '</td>';
            tr += '<td>' + menuName + '</td>';
            tr += '<td>';
            tr += '<a class="btn icon-btn" href="#n"><img src="/static/admin/assets/img/icon/up2.png" alt="위"></a><a class="btn icon-btn" href="#n"><img src="/static/admin/assets/img/icon/down2.png" alt="아래"></a><a class="btn panel-open-btn table-btn bg-purple" href="./menu_modify.html">수정</a>';
            tr += '</td>';
            tr += '</tr>';

            $(body).append(tr);
            $('.modal-close').trigger('click');
        });

        let prevEl;
        //모달 현재 뎁스 표시
        $('.panel-open-btn').click(function() {
            depth = $(this).closest('[data-dep]').index();
            prevEl = $(this).closest('.table-wrap').prev();//상위 뎁스

            switch (depth) {
                case 0:
                    $('[name="depth"]').val(depth + 1);
                    break;

                case 1:
                    prevEl = $(this).closest('.table-wrap').prev();//상위 뎁스
                    $('[name="depth"]').val(depth + 1);
                    if (prevEl.length > 0) {
                        let parentMenu = $(prevEl).find('.active');
                        if (parentMenu.length > 0) {
                            $('[name="parent_name1"]').val($(parentMenu).find('td').eq(1).text());
                            $('[name="parent_name1"]').closest('.input-wrap').removeClass('d-none');

                        } else {
                            alert("상위 메뉴를 먼저 선택해주세요.");
                            return false;
                        }
                    }
                    break;

                case 2:

                    let parentEl = $(prevEl).prev().find('.active');//상위 뎁스

                    if (prevEl.length > 0) {
                        let parentMenu = $(prevEl).find('.active');
                        if (parentMenu.length > 0 && parentEl.length > 0) {
                            $('[name="depth"]').val(depth + 1);
                            $('[name="parent_name2"]').val($(parentMenu).find('td').eq(1).text());
                            $('[name="parent_name2"]').closest('.input-wrap').removeClass('d-none');

                            $('[name="parent_name1"]').val($(parentEl).find('td').eq(1).text());
                            $('[name="parent_name1"]').closest('.input-wrap').removeClass('d-none');

                        } else {
                            alert("상위 메뉴를 먼저 선택해주세요.");
                            return false;
                        }
                    }
                    break;
            }
        });

        //메뉴 테이블 클릭
        $(document).on('click', '.t-type-02 tr', function(e) {
            let tg = e.target;
            let el;

            if (tg.tagName !== 'tr') {
                el = tg.closest('tr');
            }

            if ($(el).find('.v-hid').length > 0) {
                alert("사용하지 않는 메뉴입니다. 상태를 먼저 변경해 주세요.");
                return false;
            } else {
                $(this).addClass('active').siblings().removeClass('active');
            }
        });

        //취소 버튼
        $('.add-cancel').click(function() {
            $(this).closest('.panel-wrap').addClass('d-none');

            let wrap = $('.table-wrap.add');
            $(wrap).removeClass('add');
        });

        //언어선택-선택언어 인풋 보임

        let lang_radio = $('[name="lang"]');
        let lang;
        lang_radio.change(function() {
            lang = $(this).val();
            $('[data-lang="' + lang + '"]').removeClass('d-none').siblings('[data-lang]').addClass('d-none');
        });

        // 타입체크
        let type_option = $('.type_change');
        let page_type;

        type_option.change(function() {
            page_type = ($(this).children("option:selected").attr('data-val'));
            $('[data-type]').addClass('d-none');
            $('[data-type="' + page_type + '"]').removeClass('d-none');
        });


    })();


    //전체 체크
    (function() {
        $('.all-ch [type="checkbox"]').change(function() {
            let check = $(this).closest('table').find('.line-ch [type="checkbox"]');

            if ($(this).is(':checked')) {
                check.each(function(index, item) {
                    $(item).prop('checked', true);
                });
            } else {
                check.each(function(index, item) {
                    $(item).prop('checked', false);
                });
            }
        });
    })();


    //페이지네이션

    $('.pagination a').click(function() {
        $(this).addClass('on').siblings().removeClass('on');
    });

    // 닫기
    $(document).click(function(e) {
        let tg = e.target.className;
        let _select = tg.indexOf('select');
        if (_select < 0) {

            $('.select').removeClass('on');
        }
    });

    //파일 첨부
    (function() {
        //첨부파일 최대 갯수

        let imageMax = 5;
        let fileMax = 5;


        let file = false;
        $(document).on('click', 'input[type="file"]', function() {
            if (file === false) {
                return false;
            } else {
                file = false;
            }
        })

        //썸네일 이미지 추가/삭제 240910
        $(document).on('click', '.thumb-btn', function() {
            file = true;
            if (file === true) {
                let input = $(this).closest('.file-box').find("[type='file']").val();
                if (input === "") {
                    $(this).closest('.file-box').find("[type='file']").trigger('click');
                } else {
                    $(this).closest('.file-box').find("[type='file']").val("");
                    $(this).closest('.file-box').find("[type='file']").trigger('click');
                }
                thumbAdd($(this))
            }
        });


        function thumbAdd(el) {
            let tg = el.prev('input');

            $(document).one('change', tg, function() {
                if ($(this).closest('.file-box').find('input').val() !== "") {
                    if ($('.attach-img-list li').length < 5) {
                        let val = tg.val();
                        const fReader = new FileReader();
                        fReader.readAsDataURL(tg[0].files[0]);

                        fReader.onloadend = function(event) {
                            const imageElement = document.createElement('img');
                            const path = event.target.result;

                            let img_attach = "";
                            img_attach += '<div class="attach-file">' + val.substring(val.lastIndexOf("\\") + 1) + '</div>';
                            img_attach += '<button class="btn attach-file-del table-btn bg-deepgray" type="button">삭제</button>';

                            $('.attach-file-wrap').append(img_attach);
                            el.closest('.input-group').find('.thumb img').attr('src', path);
                        }
                    }
                }
            });
        }


        //게시물 이미지 추가 240910

        $(document).on('click', '.img-search', function() {
            file = true;
            if (file === true) {
                let input = $(this).closest('.file-box').find("[type='file']").val();//비어있는지 확인
                if (input !== "") {
                    $(this).closest('.file-box').find("[type='file']").val("");
                }
                $(this).closest('.file-box').find("[type='file']").trigger('click');
                imgAdd($(this));
            }
        });

        function imgAdd(el) {
            let tg = el.prev('input');

            $(document).one('change', tg, function() {
                if ($(this).closest('.file-box').find('input').val() !== "") {
                    if ($('.attach-img-list li').length < 5) {
                        let val = tg.val();

                        const fReader = new FileReader();
                        fReader.readAsDataURL(tg[0].files[0]);

                        fReader.onloadend = function(event) {
                            const imageElement = document.createElement('img');
                            const path = event.target.result;


                            let img_attach = "";
                            img_attach += '<li>';
                            img_attach += '<figure class="img-thumb"><img style="width:100%; height:100%;  object-fit: cover;" src="' + path + '"alt="image"></figure>';
                            img_attach += '<input type="hidden" value="' + val + '">';
                            img_attach += '<button class="btn attach-img-del bg-deepgray" type="button">삭제</button>';
                            img_attach += '</li>';


                            if ($('.attach-img-list li').length == 0) {
                                $('.attach-img-list').append(img_attach).find('input').attr('id', 'img-' + 0);

                            } else {
                                $('.attach-img-list').append(img_attach);
                            }

                            //아이디 생성
                            let timer = setTimeout(function() {

                                let li = $('.attach-img-list li');
                                if (li.length > 1) {
                                    let id = li.last().prev().find('input').attr('id');
                                    let index = id.split("-")[1];

                                    $('.attach-img-list li').last().find('input').attr('id', 'img-' + (Number(index) + 1));
                                }

                                clearTimeout(timer);
                            }, 100);
                        }
                    }
                    else {
                        alert('"이미지는 최대 "' + imageMax + '"개 까지 추가 됩니다."');
                    }
                } else {
                    return false;
                }
            });

            $(document).on('click', '.attach-img-del', function() {
                $(this).closest('li').remove();
            });
        }


        //파일첨부

        $(document).on('click', '.file-btn', function() {
            file = true;
            if (file === true) {
                if (file === true) {
                    let el = $(this).closest('.file-box').find("[type='file']")
                    let input = el.val();//비어있는지 확인
                    if (input !== "") {
                        el.val("");
                    }
                    el.trigger('click');
                    attachFile(el);
                }
            }
        });

        function attachFile(el) {
            $(el).one('change', function() {
                let outbox = el.closest('.input-group').find('.attach-file-list');
                let parentEl = el.closest('.file-box');
                let file = $(parentEl).find('input').val();

                if ($('.attach-file-list li').length < fileMax) {
                    let file_list = ""
                    file_list += '<li>';
                    file_list += '<input class="attach-file" type="text" value="' + file.substring(file.lastIndexOf("\\") + 1) + '">';
                    file_list += '<button class="btn attach-file-del table-btn bg-deepgray" type="button">삭제</button>';
                    file_list += '</li>';


                    if ($('.attach-file-list li').length === 0) {
                        outbox.append(file_list).find('input').attr('id', 'file-' + 0);
                    } else {
                        outbox.append(file_list);
                    }

                    //아이디 생성
                    let timer = setTimeout(function() {
                        let li = $('.attach-file-list li');
                        if (li.length > 1) {
                            let id = li.last().prev().find('input').attr('id');
                            let index = id.split("-")[1];
                            $('.attach-file-list li').last().find('input').attr('id', 'file-' + (Number(index) + 1));
                        }
                        clearTimeout(timer);
                    }, 100);
                } else {
                    alert('"파일 첨부는 "' + fileMax + '"개까지 가능합니다."');
                }
            });
        }


        //첨부파일 & 썸네일 삭제 240823

        $(document).on('click', '.attach-file-del', function() {
            if ($(this).closest('.input-group').find('#Thumb').length > 0) {
                $(this).parent().find('.attach-file').text("파일없음");
                $(this).closest('.input-group').find('.thumb img').attr('src', '/static/admin/assets/img/icon/null.jpg');
                $('#Thumb').val("");

            } else if ($(this).closest('.attach-file-list').length > 0) {
                $(this).closest('li').remove();
            }
        });
    })();

    $(document).ready(function() {
        // 등록 페이지 초기 상태: 숨김 처리
        if (!$('.attach-file-wrap').find('.attach-file').text().trim()) {
            $('.attach-file-wrap').hide(); // 파일명 없는 경우 숨김
        }

        // 파일 선택 시 표시 처리
        $(document).on('change', '#thumbfile', function() {
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
        $(document).on('change', '#thumbfile2', function() {
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
        $(document).on('change', '#thumbfile3', function() {
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
        $(document).on('change', '#thumbfile4', function() {
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

        // 파일 삭제 버튼 처리
        $(document).on('click', '.attach-file-del2', function() {
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

    // PDF 크기 체크
    const MAX_PDF_FILE_SIZE = 20 * 1024 * 1024; // 20MB
    function checkPdfFileSize(input) {
        if (input.files[0].size > MAX_PDF_FILE_SIZE) {
            alert('PDF 파일의 크기는 20MB를 초과할 수 없습니다.');
            input.value = '';
            return false;
        }
        return true;
    }

    // PDF 파일 선택 시 크기 검사
    $(document).on('change', '#productImg5', function() {
        if (checkPdfFileSize(this)) {
            let fileName = $(this).val().split('\\').pop();
            $(this).closest('.file-wrap').find('.attach-file').text(fileName);
        }
    });

    function readURL(input, previewId) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $(`#${previewId}`).attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            $(`#${previewId}`).attr('src', "/static/admin/assets/img/icon/null.jpg");
        }
    }

    $(document).on('change', '#Thumb', function() {
        if (checkFileSize(this)) {
            readURL(this, 'preview-thumb');
            let fileName = $(this).val().split('\\').pop();
            $(this).closest('.file-wrap').find('.attach-file').text(fileName);
        }
    });

    $(document).on('change', '#thumbfile', function() {
        if (checkFileSize(this)) {
            readURL(this, 'preview-thumb');
            let fileName = $(this).val().split('\\').pop();
            $(this).closest('.file-wrap').find('.attach-file').text(fileName);
        }
    });

    $(document).on('change', '#productImg', function() {
        if (checkFileSize(this)) {
            readURL(this, 'preview-productImg');
            let fileName = $(this).val().split('\\').pop();
            $(this).closest('.file-wrap').find('.attach-file').text(fileName);
        }
    });

    $(document).on('change', '#productImg2', function() {
        if (checkFileSize(this)) {
            readURL(this, 'preview-productImg2');
            let fileName = $(this).val().split('\\').pop();
            $(this).closest('.file-wrap').find('.attach-file').text(fileName);
        }
    });

    $(document).on('change', '#productImg3', function() {
        if (checkFileSize(this)) {
            readURL(this, 'preview-productImg3');
            let fileName = $(this).val().split('\\').pop();
            $(this).closest('.file-wrap').find('.attach-file').text(fileName);
        }
    });

    $(document).on('change', '#productImg4', function() {
        if (checkFileSize(this)) {
            readURL(this, 'preview-productImg4');
            let fileName = $(this).val().split('\\').pop();
            $(this).closest('.file-wrap').find('.attach-file').text(fileName);
        }
    });

    $(document).on('change', '[id^=Thumb]', function() {
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

    $('.thumb-add').click(function() {
        if ($(this).closest('.file-box').find('input').val() !== "") {
            let file = $('#Thumb-Img').val();
            $('.attach-file-wrap .attach-file').text(file.substring(file.lastIndexOf("\\") + 1));
        } else {
            alert("추가되는 이미지가 없습니다.");
        }
    });

    $(document).on('click', '.attach-img-del', function() {
        $(this).closest('li').remove();
    });

    //이미지 폼 클릭 불가
    $('input[type="image"]').click(function() {
        return false;
    }); //240724

    // 모달 열기
    (function() {
        $(document).on('click', '.btn', function() {
            let href = $(this).attr('data-modal');
            $(href).closest('.modal-wrap').removeClass('d-none');
        });

        //모달 닫기
        $('.modal-close').click(function() {
            $(this).closest('.modal-wrap').addClass('d-none');
            $()
        });
    })();


    //서브 인풋 박스 추가
    (function() {
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

        $(document).on('click', '.input-add', function() {
            let item = $(this).closest('.modal-body').find('.input-box').length;
            if (item < Max) {
                $('.modal-body').append(sub_menu);
            } else if (item >= Max) {
                alert('하위 메뉴는 ' + Max + '개 까지만 추가 가능합니다.');
            }
        });
    })();

    //삭제
    (function() {
        $(document).on('click', '.del-btn', function() {
            if ($(this).closest('.file-box')) {
                $(this).closest('.file-box').remove();
            }
            if ($(this).closest('.sub-menu')) {
                $(this).closest('.sub-menu').remove();
            }
        });
    })();


    //탭
    (function() {
        if ($('.tap').length > 0) {
            $('.tap a').click(function() {
                $('.tab_li').removeClass('active');
                $(this).parent().addClass('active');
            });
        }
    })();


    //테이블 선택 라인 배경색 바끔
    (function() {
        $('.line-ch input').change(function() {
            $(this).closest('tr').toggleClass('active');
        });
    })();


    //회원 보기/수정 모달 input 입력 방지
    $('#UserView').find('input').attr('readonly', 'readonly');
    $('#UserView .select').attr('disabled', true);
    $('#UserMody [type="password"]').attr('readonly', 'readonly');


    //데이트 피커
    (function() {
        $('[data-toggle=bizDate]').datepicker({
            trigger: ".bizDate-btn",
            format: 'yyyy-mm-dd',
            language: 'ko-KR',
            autoHide: 'true',
        });

        $('[data-toggle=birthday]').datepicker({
            trigger: ".birthday-btn",
            format: 'yyyy-mm-dd',
            language: 'ko-KR',
            autoHide: 'true',
        });
    })();


    //데이트 피커 - 기간 선택
    (function() {
        var $startDate = $('.start-date');
        var $endDate = $('.end-date');

        $startDate.datepicker({
            trigger: ".start-date-btn",
            format: 'yyyy-mm-dd',
            language: 'ko-KR',
            autoHide: 'true',
        });
        $endDate.datepicker({
            trigger: ".end-date-btn",
            format: 'yyyy-mm-dd',
            language: 'ko-KR',
            autoHide: 'true',
            startDate: $startDate.datepicker('getDate'),
        });

        $startDate.on('change', function() {
            $endDate.datepicker('setStartDate', $startDate.datepicker('getDate'));
        });
    })();


    //팝업닫기
    (function() {
        $('.day-close,.popup-close').click(function() {
            $(this).closest('.popup-wrap').addClass('d-none');
        });
    })();

    //썸네일 이미지 클릭방지
    $('.thumb input').click(function(e) {
        e.preventDefault();
        return false;
    });


    //테이블 버튼 칸 너비
    (function() {
        let td = $('table tbody tr td:last-child');
        let btn = td.find('.btn');
        let col = td.closest('table').find('colgroup').find('.btn-line');
        let prevEa = 0;
        let btnEa = 0;

        td.each(function(index, item) {
            let size = $(item).find('.btn').length;
            if (size > prevEa) {
                prevEa = size;
                col.css({ width: (50 + (btn.eq(0).outerWidth(true) * prevEa) + 'px') });
            } else {
                btnEa = prevEa;
                if (btnEa > prevEa) {
                    col.css({ width: (50 + (btn.eq(0).outerWidth(true) * btnEa) + 'px') });
                }
            }
        });
    })();


    //데이터 없을때 셀 합치기
    (function() {
        if ($('.t-null').length > 0) {
            $('.t-null').each(function(index, item) {
                let table = $(item).closest('table');
                let cell = table.find('thead th').length;

                $(item).find('th').attr('colspan', cell);
                $(item).css({ borderBottom: '1px solid #e0e0e3' });
            });
        }
    })();


    //페이지 관리
    (function() {
        $(document).on('click', '.list-open-btn', function(e) {
            let tg = e.target;
            let el = $(tg).closest('.page-depth');

            if (!$(el).hasClass('active')) {
                $(el).addClass('active').find('>.page-depth-wrap').slideDown();
                $(el).siblings().removeClass('active').find('>.page-depth-wrap').slideUp();
            } else {
                $(el).removeClass('active').find('>.page-depth-wrap').slideUp();
            }
        });
    })();

    // 컬럼 게시판 태그 증가/증감
    $(".desc-add").on("click", function() {
        const existingTags = $("input[id^='tag']");
        const count = existingTags.length;

        if (count >= 3) {
            alert("태그는 최대 3개까지 입력할 수 있습니다.");
            return;
        }

        for (let i = 2; i <= 3; i++) {
            if ($(`#tag${i}`).length === 0) {
                const newInput = `
          <input class="flex-1" id="tag${i}" name="tag${i}" type="text" placeholder="#태그${i}">
        `;
                $("input[id^='tag']").last().after(newInput);
                break;
            }
        }
    });

    $(".desc-del").on("click", function() {
        const currentTags = $("input[id^='tag']");

        if (currentTags.length <= 1) {
            alert("최소 한 개의 태그는 남겨야 합니다.");
            return;
        }

        for (let i = 3; i >= 2; i--) {
            if ($(`#tag${i}`).length > 0) {
                $(`#tag${i}`).remove();
                break;
            }
        }
    });
});