json.data @faqs do |faq|
  json.id faq.id
  json.question faq.question
  json.answer faq.answer

  json.category faq.faq_category, :id, :name
end

