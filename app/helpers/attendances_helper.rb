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
  def started_at_time
    str = @attendance.started_at
    if str.min.between?(0, 14)
      @str_display = str.change(min: 0)
    elsif str.min.between?(15, 29)
      @str_display = str.change(min: 15)
    elsif str.min.between?(30, 44)
      @str_display = str.change(min: 30)
    elsif str.min.between?(45, 59)
      @str_display = str.change(min: 45)
    end
  end
  
  #出勤時間と退勤時間を受け取り、在社時間を計算して返す
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
end
