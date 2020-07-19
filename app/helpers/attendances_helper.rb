module AttendancesHelper
  
  def attendance_state(attendance)
    #受け取ったAttendanceオブジェクトが当日と一致するか評価する
    if Date.current == attendance.worked_on
      return "出勤" if attendance.started_at.nil?
      return "退勤" if attendance.started_at.present? && attendance.finished_at.nil?
    end
    #どれにも当てはまらなかった場合はfalseを返す
    false
  end
  
  #出勤時間を受け取り、15分単位にしたものを返す
  # def time_convertion(str_fin)
  #   @display_time = str_fin
  #   case @display_time.min
  #   when 0..14
  #     @display_time.change(min: 0)
  #   when 15..29
  #     @display_time.change(min: 15)
  #   when 30..44
  #     @display_time.change(min: 30)
  #   when 45..59
  #     @display_time.change(min: 45)
  #   else 
  #   end
  # end
  
  #出勤時間と退勤時間を受け取り、在社時間を計算して返す
  def working_times(start, finish)
    format("%.2f", (((finish.floor_to(15.minute) - start.floor_to(15.minute)) / 60) / 60.0))
  end
end
