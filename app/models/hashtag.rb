require_relative '../../db/db_connector'

class Hashtag
    attr_accessor :hashtags
    def initialize(hashtags)
        @hashtags = hashtags
    end

    def valid_tag?
        if @hashtags.nil? || @hashtags.empty?
            false
        end
        true
    end

    def formatted_hashtag
        hashtags = @hashtags.map(&:downcase).uniq
        data = Array.new
        hashtags.each do |tag|
            data.push(tag)
        end
        data
    end

    def save
        client = create_db_client
        hashtags = formatted_hashtag
        data = Array.new
        hashtags.each do |tag|
            client.query("INSERT INTO hashtags(tag,count) VALUES ('#{tag}', 1) ON DUPLICATE KEY UPDATE count = VALUES(count) + 1")
            temp = client.query("select * from hashtags where tag = '#{tag}'").each[0]
            data.push(temp)
        end
        data
    end

    def self.trending_tags
        client = create_db_client
        post = Hash.new
        posts = Array.new
        top_5_in_24_hours = Array.new
        query = "SELECT post_comment_hashtags.hashtag_id, hashtags.tag, COUNT(hashtag_id) AS total 
        FROM ( SELECT hashtag_id, created_at FROM post_hashtags UNION ALL SELECT hashtag_id, created_at 
        FROM comment_hashtags WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 DAY)) 
        AS post_comment_hashtags JOIN hashtags ON post_comment_hashtags.hashtag_id = hashtags.id 
        GROUP BY hashtag_id ORDER BY total desc limit 5"
        rawData = client.query(query)
        rawData.each do |data|
            post = {:hashtag_id => data['hashtag_id'], :Hashtag_tag => data['tag'], 
                :Hashtag_count => data['total'],}
            posts.push(post)
        end
        posts
    end
end