#
# disabling wrapping html form elements that yield validation erros with
# <div class="field_with_errors">...</div>
ActionView::Base.field_error_proc = -> (html_tag, instance) { html_tag }