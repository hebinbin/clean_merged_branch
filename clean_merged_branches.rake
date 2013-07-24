namespace :tool do
  desc "delete remote branches which have already merged to current branch"
  task :clean_merged_branches => :environment do
    keyword = ENV["keyword"].try(:strip)

    if keyword.blank?
      puts "Please input your keyword of branch name!!!\n"
      puts "[Usage]: bundle exec rake tool:clean_merged_branches keyword=***"
      exit
    end

    %x{git branch -r --merged | grep "#{keyword}"}.split("\n").each do |branch|
      branch_name = branch.strip.split("/").last

      go_to_delete_remote_branch(branch_name)
      go_to_delete_local_branch(branch_name)
    end
  end
end

def go_to_delete_remote_branch(branch_name)
  unless %x{git branch -r | grep "#{branch_name}"}.empty?
    check_input_for_remote(branch_name)
  else
    puts "Do not have any REMOTE branch matched #{branch_name}"
  end
end

def check_input_for_remote(branch_name)
  puts "Do you want to delete REMOTE branch: #{branch_name} (y|n):"
  word = STDIN.gets
  case word.chomp.strip.downcase
  when "y"
   delete_remote_branch(branch_name)
  when "n"
   puts "[Warn]: you do not want to delete REMOTE branch!!!\n"
  else
   puts "Please input (y|n)!!!\n"
   check_input_for_remote(branch_name)
  end
end

def delete_remote_branch(branch_name)
  %x{git push origin :refs/heads/"#{branch_name}"}
end

def go_to_delete_local_branch(branch_name)
  unless %x{git branch | grep "#{branch_name}"}.empty?
    check_input_for_local(branch_name)
  else
    puts "Do not have any LOCAL branch matched #{branch_name}"
  end
end

def check_input_for_local(branch_name)
  puts "Do you want to to delete LOCAL branch: #{branch_name}? (y|n):"
  word = STDIN.gets
  case word.chomp.strip.downcase
  when "y"
   delete_local_branch(branch_name)
  when "n"
   puts "[warn]: you do not want to delete #{branch_name}\n"
  else
   puts "Please input (y|n)!!!\n"
   check_input_for_local(branch_name)
  end
end

def delete_local_branch(branch_name)
  %x{git branch -D "#{branch_name}"}
end
