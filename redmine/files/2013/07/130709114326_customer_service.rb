$:.unshift File.dirname(__FILE__)
require 'savon'
require 'authentication_service'
require 'babosa'
require 'time'
require 'eudonet_record'


class CustomerService
  extend Savon::Model

  client wsdl: 'http://ww5.eudonet.com/v7/app/specif/eudo_03794/ws/PM.asmx?wsdl'
  # [:add, :update, :delete, :search_by_id, :search_by_custom_field, :search_by_main_field, :get_mru, :search_by_filter_name, :search_by_custom_fields, :search_by_filter_id]

  client soap_version: 2
  client log: false

  operations :search_by_filter_id, :search_by_custom_field, :search_by_id

  def initialize
  end

  class << self
    def list
      search_by_filter_id(message: { token: AuthenticationService.new.authenticate, nFilterId: 25 })
    end

    # def list_company
    #   search_by_id(message: { token: AuthenticationService.new.authenticate, sFieldNameId: "societe"})
    # end

    def list_companies
      results = list.to_hash[:search_by_filter_id_response][:search_by_filter_id_result]

      companies = []
      fields = results[:fields][:field]
      pm_datas = results[:results][:pm_data]
      pm_datas.each do |pm_data|
        companies << CustomerRecord.new(fields, pm_data)
      end
      companies
    end

    def list_peoples
      results = list.to_hash[:search_by_filter_id_response][:search_by_filter_id_result]

      peoples = []
      fields = results_peoples[:fields][:field]
      pm_datas = results[:results][:pm_data]
      pm_datas.each do |pm_data|
        peoples << CustomerRecord.new(fields, pm_data)
      end
      peoples
    end

    def last_modified(date = Time.now - (60 * 60 * 24))
      #
      # PM96: 'Modifiée le'
      search_by_custom_field(message: { token: AuthenticationService.new.authenticate, sOperator: 4, sValue: date.xmlschema, sField: 'PM96'  })
    end
  end
end

