$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'eudonet_service'

companies = CustomerService.list_companies
companies.each do |company|
  puts "------ Modele -------"
  company.methods.sort.each do |meth|
    puts "#{meth}:\t#{company.send(meth)}"
  end
  puts
end
Kernel.exit
results = CustomerService.list_company.to_hash[:search_by_filter_id_response][:search_by_filter_id_result]
# results = Customer.list.to_array(:search_by_filter_id_response, :search_by_filter_id_result)

fields = results[:fields][:field]
customers = results[:results][:pm_data]

models = []
customers.each do |customer|
  puts [ customer[:pm69], customer[:pm11] ].join(' ')
  customer.each do |k,v|
    puts "#{k}:\t#{v}"
  end
  puts
  models << CustomerRecord.new(fields, customer)
end

#  Kernel.exit
puts
# Customer.list.to_hash[:search_by_filter_id_response][:search_by_filter_id_result][:fields][:field].each do |f|
#  puts "#{f[:@field_name]}:\t#{f[:@libelle]}\t#{f[:@libelle].to_slug.normalize.to_ruby_method}"
#end

models.each do |customer|
  puts "------ Mod -------"
  #puts customer.societe
  #puts customer.adresse1
  #puts customer.ville
  customer.methods.sort.each do |meth|
    puts "#{meth}:\t#{customer.send(meth)}"
  end
end

puts
puts models.last.methods.sort.inspect


# CustomerService.last_modified(Time.now - ( 50 * 86400 ))
