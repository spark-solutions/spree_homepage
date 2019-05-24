//= require spree/backend

$(function() {
  var elements = {
    content: $('#home_page_field_content_field'),
    image: $('#home_page_field_image_field'),
    section: $('#home_page_field_home_page_section_id'),
    fieldType: $('#home_page_field_home_page_field_type_id')
  }

  function filterFieldTypes() {
    var fieldTypeIds = elements.section
      .find(':selected')
      .data('homePageFieldTypes')
    var fieldTypeIdsTable = String(fieldTypeIds).split(' ')
    elements.fieldType.find('option').each(function(id, option) {
      var $option = $(option)
      var value = $option.val()
      if (fieldTypeIdsTable.indexOf(value) === -1) {
        $option.attr('disabled', 'disabled')
      } else {
        $option.removeAttr('disabled')
      }
    })
  }

  function switchContentView() {
    if (elements.fieldType.find(':selected').data('type') === 'text') {
      elements.image.hide()
      elements.content.show()
    } else {
      elements.image.show()
      elements.content.hide()
    }
  }

  function onSectionChange() {
    elements.fieldType.val(null).trigger('change')
    filterFieldTypes()
  }

  function onFieldTypeChange() {
    switchContentView()
  }

  if (elements.fieldType.length) {
    filterFieldTypes()
    switchContentView()
    elements.section.on('change', onSectionChange)
    elements.fieldType.on('change', onFieldTypeChange)
  }
})
