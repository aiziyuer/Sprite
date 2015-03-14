=begin
模拟生产者和消费者模型

author: moss
date: 2015.3.15
=end

require 'thread/pool'
require 'set'


# 线程池
pool = Thread.pool(500)

# 结果队列
queue = Queue.new

# 结果集
set = Set.new

# 生产者
100.times.each do |i|

  pool.process do

    index = 0
    while index<1000
      queue << "#{i}-#{index}"
      index += 1
    end

  end

end


# 消费者
400.times.each do

  pool.process do

    until queue.empty?

      item = queue.pop(true) rescue nil

      if item
        set << item
      end

    end

  end

end


# 等待所有任务完成
pool.shutdown

puts set.size
