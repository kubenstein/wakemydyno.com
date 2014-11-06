require 'spec_helper'

describe BackgroundProcessesService do

  context 'pinging process' do
    it 'should ping in the loop' do
      loop_runs = 2
      perform_calls_count = 0
      PingService.any_instance.stub(:perform) { perform_calls_count += 1 }
      BackgroundProcessesService.start_ping_process(initial_sleep = 0.seconds,
                                                    loop_condition = -> { (loop_runs = loop_runs -1) > -1 },
                                                    inloop_sleep = 0.minutes)
      expect(perform_calls_count).to eq 2
    end

    it 'should wait initial time' do
      start_time = Time.now
      BackgroundProcessesService.start_ping_process(initial_sleep = 2.seconds,
                                                    loop_condition = -> { false },
                                                    inloop_sleep = 0.minutes)
      end_time = Time.now
      expect((end_time - start_time).to_i).to eq 2
    end

    it 'should wait between pings' do
      loop_runs = 1
      start_time = Time.now
      BackgroundProcessesService.start_ping_process(initial_sleep = 0.seconds,
                                                    loop_condition = -> { (loop_runs = loop_runs -1) > -1 },
                                                    inloop_sleep = 2.seconds)
      end_time = Time.now
      expect((end_time - start_time).to_i).to eq 2
    end

  end


  context 'checking process' do
    it 'should check in the loop' do
      loop_runs = 2
      perform_calls_count = 0
      UrlCheckService.any_instance.stub(:perform) { perform_calls_count += 1 }
      BackgroundProcessesService.start_url_check_process(initial_sleep = 0.seconds,
                                                         loop_condition = -> { (loop_runs = loop_runs -1) > -1 },
                                                         inloop_sleep = 0.hours)
      expect(perform_calls_count).to eq 2
    end

    it 'should wait initial time' do
      start_time = Time.now
      BackgroundProcessesService.start_url_check_process(initial_sleep = 2.seconds,
                                                         loop_condition = -> { false },
                                                         inloop_sleep = 0.hours)
      end_time = Time.now
      expect((end_time - start_time).to_i).to eq 2
    end

    it 'should wait between pings' do
      loop_runs = 1
      start_time = Time.now
      BackgroundProcessesService.start_url_check_process(initial_sleep = 0.seconds,
                                                         loop_condition = -> { (loop_runs = loop_runs -1) > -1 },
                                                         inloop_sleep = 2.seconds)
      end_time = Time.now
      expect((end_time - start_time).to_i).to eq 2
    end

  end


end
