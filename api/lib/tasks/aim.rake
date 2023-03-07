namespace :aim do
  task :aim => :environment do
    sheet = Google::Spreadsheets.new
    val = sheet.get_values(ENV['SHEET_ID'], ['目標!A2:E']).values
    Aim.all.each do |f|
      f.destroy
    end
    val.each do |title, reason, advantage, genre, difficulty|

      Aim.create!(
        { title: title, reason: reason, advantage: advantage, genre: genre, difficulty: difficulty }
      )
    end
  end
end
