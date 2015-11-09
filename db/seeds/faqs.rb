config = YAML.load_file Rails.root.join('db/data/faqs.yml')

def permit_faq_category(params)
  {
    id: params['id'],
    name: params['name'],
  }
end

def permit_faq(params)
  {
    question: params['name'],
    answer: params['answer']
  }
end

def create_faq_category(attrs)
  id = attrs.delete('id')
  faq_category = Faq::Category.find_by_id id

  if faq_category
    faq_category.update_attributes! permit_faq_category(attrs)
  else
    faq_category = Faq::Category.create! permit_faq_category(attrs)
  end

  faq_category
end

def create_faq(attrs, faq_category)
  faq = Faq.find_by(faq_category: faq_category, question: attrs['question'], answer: attrs['answer'])

  if faq
    faq.faq_category = faq_category
    faq.update_attributes! attrs
  else
    faq = Faq.new(attrs)
    faq.faq_category = faq_category
    faq.save!
  end
end

ActiveRecord::Base.transaction do
  config.each do |attr|
    faq_category = create_faq_category(attr)

    attr['faqs'].to_a.each do |faq_attrs|
      faq = create_faq(faq_attrs, faq_category)
    end
  end
end

