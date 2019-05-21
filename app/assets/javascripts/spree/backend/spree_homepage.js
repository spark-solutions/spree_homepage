//= require spree/backend

$(function () {
  var elements = {
    fieldType: $('#home_page_field_field_type'),
    content: $('#home_page_field_content_field'),
    image: $('#home_page_field_image_field')
  }
  function switchView() {
    if (elements.fieldType.val() === 'text') {
      elements.image.hide()
      elements.content.show()
    } else {
      elements.image.show ()
      elements.content.hide()
    }
  }
  if (elements.fieldType) {
    switchView()
    elements.fieldType.on('change', switchView)
  }
})
