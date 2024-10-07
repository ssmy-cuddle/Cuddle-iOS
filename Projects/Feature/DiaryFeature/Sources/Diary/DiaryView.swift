//
//  DiaryView.swift
//  DiaryFeature
//
//  Created by mvldev7 on 9/20/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let time: String
}

public struct DiaryView: View {
    private var store: StoreOf<DiaryFeature>
    
    public init(store: StoreOf<DiaryFeature>) {
        self.store = store
    }
    
    @State private var selectedDate = Date()
    private let calendar = Calendar.current
    
    // Sample events
    private let events = [
        Event(title: "일상", description: "Aspen is as close...", time: "11:35"),
        Event(title: "일상", description: "Aspen is as close...", time: "13:15"),
        Event(title: "일상", description: "Aspen is as close...", time: "15:10"),
        Event(title: "간식 구매", description: "초코에 줄 간식 구매...", time: "15:10")
    ]
    
    private var groupedEvents: [String: [Event]] {
        Dictionary(grouping: events, by: { $0.time })
    }
    
    public var body: some View {
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 10, day: 1))!
        let firstDayOfWeek = calendar.component(.weekday, from: startDate)
        
        return ScrollViewReader { scrollProxy in
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    monthView
                    
                    Spacer()
                    
                    if !calendar.isDateInToday(selectedDate) {
                        Button(action: {
                            withAnimation {
                                selectedDate = Date()
                                
                                let todayIndex = calendar.component(.day, from: Date()) + firstDayOfWeek - 2
                                scrollProxy.scrollTo(todayIndex, anchor: .center)
                            }
                        }) {
                            Text("Today")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 88/255, green: 226/255, blue: 168/255))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .background(Color(red: 88/255, green: 174/255, blue: 226/255).opacity(0.1))
                                .cornerRadius(7)
                        }
                    }
                }
                .padding(.bottom, 13)
                .padding(.horizontal, 24)
                
                VStack(spacing: 0) {
                    dayView(startDate: startDate, firstDayOfWeek: firstDayOfWeek, scrollProxy: scrollProxy)
                        .padding(.top, 14)
                        .background(Color.white)
                    
                    Divider()
                        .frame(height: 0.85)
                        .background(Color(red: 250/255, green: 249/255, blue: 249/255, opacity: 1))
                    
                    HStack {
                        Text("시간")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 188/255, green: 193/255, blue: 205/255))
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        Text("여정")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 188/255, green: 193/255, blue: 205/255))
                            .padding(.trailing, 20)
                    }
                    .padding(.vertical, 5)
                    
                    timelineView
                        .padding()
                }
                .background(Color.white)
                .clipShape(RoundedCorner(radius: 32, corners: [.topLeft, .topRight]))
            }
            .background(Color(red: 250/255, green: 249/255, blue: 249/255))
        }
    }
    
    // MARK: - 타임라인
    private var timelineView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(groupedEvents.keys.sorted(), id: \.self) { time in
                    if let eventsForTime = groupedEvents[time] {
                        ForEach(eventsForTime.indices, id: \.self) { index in
                            let shouldShowTime = index == 0
                            timelineCardView(event: eventsForTime[index], shouldShowTime: shouldShowTime, time: time)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - 타임라인 카드
    private func timelineCardView(event: Event, shouldShowTime: Bool, time: String) -> some View {
        HStack(alignment: .top, spacing: 13) {
            VStack {
                if shouldShowTime {
                    Text(time)
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 33/255, green: 37/255, blue: 37/255))
                        .frame(width: 60, alignment: .leading)
                } else {
                    Spacer()
                        .frame(width: 60)
                }
            }
            .padding(.vertical, 6)
            
            Rectangle()
                .frame(width: 2)
                .foregroundColor(Color(red: 250/255, green: 249/255, blue: 249/255))
                .edgesIgnoringSafeArea(.vertical)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(event.title)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(red: 33/255, green: 37/255, blue: 37/255))
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
                
                HStack(alignment: .top, spacing: 12) {
                    Text(event.description)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                        .truncationMode(.tail)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
            .foregroundColor(.black)
            .frame(width: 213)
            .padding(.vertical, 6)
        }
    }
    
    // MARK: - Month View
    private var monthView: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Text("\(calendar.component(.day, from: selectedDate))")
                .font(.system(size: 37))
                .foregroundColor(Color(red: 33/255, green: 37/255, blue: 37/255))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(weekday(from: selectedDate))
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 188/255, green: 193/255, blue: 205/255))
                
                Text("\(calendar.component(.year, from: selectedDate))")
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 188/255, green: 193/255, blue: 205/255))
                    .textCase(.none)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Day View
    private func dayView(startDate: Date, firstDayOfWeek: Int, scrollProxy: ScrollViewProxy) -> some View {
        let daysInMonth = calendar.range(of: .day, in: .month, for: startDate)!.count
        let days = Array(repeating: "", count: firstDayOfWeek - 1) + (1...daysInMonth).map { String($0) }
        
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(days.indices, id: \.self) { index in
                    let dayString = days[index]
                    let isBlank = dayString.isEmpty
                    let dayInt = Int(dayString) ?? 0
                    
                    let currentDate = isBlank ? nil : calendar.date(byAdding: .day, value: dayInt - 1, to: startDate)
                    let isSelected = currentDate != nil && calendar.isDate(currentDate!, inSameDayAs: selectedDate)
                    
                    if !isBlank {
                        VStack(spacing: 5) {
                            VStack {
                                Text(weekday(for: index))
                                    .font(.system(size: 10))
                                    .foregroundColor(isSelected ? Color.white : Color(red: 188/255, green: 193/255, blue: 205/255))
                                
                                Text(dayString)
                                    .font(.system(size: 14))
                                    .foregroundColor(isSelected ? Color.white : Color(red: 33/255, green: 37/255, blue: 37/255))
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .frame(width: UIScreen.main.bounds.width / 7)
                            .background(isSelected ? Color(red: 252/255, green: 199/255, blue: 25/255) : Color.clear)
                            .cornerRadius(8.53)
                        }
                        .id(index)
                        .onTapGesture {
                            if let currentDate = currentDate {
                                selectedDate = currentDate
                            }
                        }
                    } else {
                        Spacer().frame(width: 0)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .onAppear {
                // 초기에 선택된 날짜로 스크롤 이동
                let selectedIndex = firstDayOfWeek + calendar.component(.day, from: selectedDate) - 2
                scrollProxy.scrollTo(selectedIndex, anchor: .center)
            }
        }
    }
    
    // MARK: - 날짜 계산을 위한 함수
    private func weekday(for index: Int) -> String {
        let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
        return weekdays[index % 7]
    }
    
    private func weekday(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
