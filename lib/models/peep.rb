require_relative '../database_connection'
class Peep
  attr_accessor :content, :id, :date
  def initialize(content:, date:)
    @content = content
    @date = date
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM peeps ORDER BY date_added DESC;")
    result.map { |record| Peep.new(content: record['content'], date: record['date_added']) }
  end

  def self.create(content:, user_id:)
    DatabaseConnection.query("INSERT INTO peeps (content, user_id) VALUES ('#{content}', '#{user_id}');")
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM peeps WHERE id = #{id};")
    result.map { |record| Peep.new(content: record['content'], date: record['date_added']) }.first
  end

  def self.update(id:, content:)
    DatabaseConnection.query("UPDATE peeps SET content = '#{content}' WHERE id = #{id};")
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM peeps WHERE id = #{id};")
  end
end
