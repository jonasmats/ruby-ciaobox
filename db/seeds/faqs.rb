config = YAML.load_file Rails.root.join('db/data/faqs.yml')

def create_faq_category(attrs)
  faq_category = Faq::Category.find_or_create_by(attrs)
end

def create_faq(attrs, faq_category)
  faq = Faq.find_or_create_by(faq_category: faq_category, question: attrs['question'], answer: attrs['answer'])
end

ActiveRecord::Base.transaction do
  config.each do |attr|
    faq_category = create_faq_category(attr['category'])

    attr['faqs'].to_a.each do |faq_attrs|
      faq = create_faq(faq_attrs, faq_category)
    end
  end
end

