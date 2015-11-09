json.data @categories do |category|
  json.id category.id
  json.name category.name

  json.faqs category.faqs, :id, :question, :answer

end

