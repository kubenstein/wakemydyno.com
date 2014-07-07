class UrlCheckService

  def perform
    Url.find_each do |url|
      puts "checking #{url.address}"
      url.check!
      if url.marked_for_deletion?
        puts "Deleting #{url.address}"
        url.destroy
      end
    end
  end

end
