require 'google/apis/sheets_v4'

class Google::Spreadsheets
  def initialize
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.authorization = authorize
  end

  def authorize
    json_key = JSON.generate(
      private_key: ENV['PRIVATE_KEY'],
      client_email: ENV['CLIENT_EMAIL']
    )

    json_key_io = StringIO.new(json_key)

    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: json_key_io,
      scope: ['https://www.googleapis.com/auth/spreadsheets']
    )
    authorizer.fetch_access_token!
    authorizer
  end

  def get_values(spreadsheet_id, ragne)
    @service.get_spreadsheet_values(spreadsheet_id, ragne)
  end
end
