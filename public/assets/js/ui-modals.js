var UIModals = function () {
    //function to initiate bootstrap extended modals
    var initModals = function () {
        var url = $('.site_url').val();
        $.fn.modalmanager.defaults.resize = true;
        $.fn.modal.defaults.spinner = $.fn.modalmanager.defaults.spinner =
            '<div class="loading-spinner" style="width: 200px; margin-left: -100px;">' +
            '<div class="progress progress-striped active">' +
            '<div class="progress-bar" style="width: 100%;"></div>' +
            '</div>' +
            '</div>';
        var $modal = $('#ajax-modal');
        $('.ajax .demo').on('click', function () {
            // create the backdrop and wait for next modal to be triggered
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modal.load('modal_ajax_test.html', '', function () {
                    $modal.modal();
                });
            }, 1000);
        });
        $modal.on('click', '.update', function () {
            $modal.modal('loading');
            setTimeout(function () {
                $modal
                    .modal('loading')
                    .find('.modal-body')
                    .prepend('<div class="alert alert-info fade in">' +
                        'Updated!<button type="button" class="close" data-dismiss="alert">&times;</button>' +
                        '</div>');
            }, 1000);
        });

      /*  var $modalQuestionInputType = $('#ajax-question-input-type');
        $('.question-input-type').on('click', function () {
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalQuestionInputType.load(url+'/admin/question/input/type', '', function () {
                    $modalQuestionInputType.modal();
                });
            }, 1000);
        });*/

        var $modalCompanyShow = $('#ajax-company-show');
        $('.company-show').on('click', function () {
            var id = $(this).data('company-id');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalCompanyShow.load(url+'/admin/company/show/'+id, '', function () {
                    $modalCompanyShow.modal();
                });
            }, 1000);
        });

        var $modalCampaignCategory = $('#ajax-campaign-category-show');
        $('.campaign-category-show').on('click', function () {
            var id = $(this).data('campaign-category-id');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalCampaignCategory.load(url+'/admin/campaign/category/show/'+id, '', function () {
                    $modalCampaignCategory.modal();
                });
            }, 1000);
        });

        var $modalSurveyCampaign = $('#ajax-survey-campaign-show');
        $('.survey-campaign-show').on('click', function () {
            var id = $(this).data('survey-campaign-id');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalSurveyCampaign.load(url+'/admin/survey/campaign/show/'+id, '', function () {
                    $modalSurveyCampaign.modal();
                });
            }, 1000);
        });

        var $modalSurveyQuestion = $('#ajax-survey-question-show');
        $('.survey-question-show').on('click', function () {
            var id = $(this).data('survey-question-id');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalSurveyQuestion.load(url+'/admin/question/show/'+id, '', function () {
                    $modalSurveyQuestion.modal();
                });
            }, 1000);
        });


        var $modalMoreQuestion = $('#ajax-more-question');
        $('.add-more-question').on('click', function () {
            var campaign_id = $(this).data('campaign-id');
            var page_number = $(this).data('page-number');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalMoreQuestion.load(url+'/admin/question/ajax/create/'+campaign_id+'/'+page_number, '', function () {
                    $modalMoreQuestion.modal();
                });
            }, 1000);
        });

        var $modalEditQuestionOptionGroup = $('#ajax-question-option-group-edit');
        $('.edit_question_option_group').on('click', function () {
            var id = $(this).data('question-option-group-id');
            var question_id = $(this).data('question-id');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalEditQuestionOptionGroup.load(url+'/admin/question/option/group/edit/'+id+'/'+question_id,'', function () {
                    $modalEditQuestionOptionGroup.modal();
                });
            }, 1000);
        });

        var $modalQuestionEdit = $('#ajax-question-edit');
        $('.edit_question').on('click', function () {
            var campaign_id = $(this).data('campaign-id');
            var question_id = $(this).data('question-id');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalQuestionEdit.load(url+'/admin/question/edit/'+campaign_id+'/'+question_id,'', function () {
                    $modalQuestionEdit.modal();
                });
            }, 1000);
        });

        var $modalAddOption = $('#ajax-question-option-group-add');
        $('.add-question-option').on('click', function () {
            var campaign_id = $(this).data('campaign-id');
            var question_id = $(this).data('question-id');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalAddOption.load(url+'/admin/question/option/group/add/'+campaign_id+'/'+question_id,'', function () {
                    $modalAddOption.modal();
                });
            }, 1000);
        });


        var $modalBranchQuestion = $('#ajax-branch-question');
        $('.add-branch-question').on('click', function () {
            var campaign_id = $(this).data('campaign-id');
            var page_number = $(this).data('page-number');
            //alert(page_number);
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalBranchQuestion.load(url+'/admin/branch/question/ajax/create/'+campaign_id+'/'+page_number,'', function () {
                    $modalBranchQuestion.modal();
                });
            }, 1000);
        });


        var $modalEditBranchQuestion = $('#ajax-edit-branch-question');
        $('.edit-branching').on('click', function () {
            var campaign_id = $(this).data('campaign-id');
            var page_number = $(this).data('page-number');
            var question_id = $(this).data('question-id');
            //alert(page_number);
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalEditBranchQuestion.load(url+'/admin/branch/question/ajax/edit/'+campaign_id+'/'+page_number+'/'+question_id,'', function () {
                    $modalEditBranchQuestion.modal();
                });
            }, 1000);
        });



        var $modalLabel = $('#ajax-label-question');
        $('.add-label-name').on('click', function () {
            var question_option_group_id = $(this).data('question-option-group-id');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalLabel.load(url+'/admin/question/option/group/label/create/'+question_option_group_id,'', function () {
                    $modalLabel.modal();
                });
            }, 1000);
        });


        var $modalLabelEdit = $('#ajax-edit-label-question');
        $('.edit-option-label-name').on('click', function () {
            var question_option_group_id = $(this).data('question-option-group-id');
            $('body').modalmanager('loading');
            setTimeout(function () {
                $modalLabelEdit.load(url+'/admin/question/option/group/label/edit/'+question_option_group_id,'', function () {
                    $modalLabelEdit.modal();
                });
            }, 1000);
        });



    };
    return {
        init: function () {
            initModals();
        }
    };
}();