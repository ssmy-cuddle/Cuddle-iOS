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
        VStack(alignment: .center, spacing: 20) {
            // Month view (calendar)
            monthView
        
            ZStack {
                dayView
                blurView
            }
            .frame(height: 30)
            .padding(.horizontal, 20)
            
            // Timeline
            timelineView
                .padding()
        }
    }
    
    // MARK: - 타임라인 표시
    private var timelineView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(groupedEvents.keys.sorted(), id: \.self) { time in
                    if let eventsForTime = groupedEvents[time] {
                        ForEach(eventsForTime.indices, id: \.self) { index in
                            // Show time only for the first card in the group
                            let shouldShowTime = index == 0
                            timelineCardView(event: eventsForTime[index], shouldShowTime: shouldShowTime, time: time)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - 타임라인 카드뷰
    private func timelineCardView(event: Event, shouldShowTime: Bool, time: String) -> some View {
        HStack(alignment: .top, spacing: 13) {
            VStack {
                if shouldShowTime {
                    Text(time)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .frame(width: 60, alignment: .leading)
                } else {
                    Spacer()
                        .frame(width: 60)
                }
            }
            .padding(.vertical, 6)

            Rectangle()
                .frame(width: 2)
                .foregroundColor(Color.gray)
                .edgesIgnoringSafeArea(.vertical)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(event.title)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }

                HStack(alignment: .top, spacing: 12) {
//                    Image("meerkats")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .cornerRadius(10)

                    Text(event.description)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                        .truncationMode(.tail)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.blue))
            .foregroundColor(.white)
            .frame(width: 213)
            .padding(.vertical, 6)
        }
    }
    
    // MARK: - 월 뷰
    private var monthView: some View {
        HStack(spacing: 30) {
            Button(
                action: {
                    changeMonth(-1)
                },
                label: {
                    Image(systemName: "chevron.left")
                        .padding()
                }
            )
            
            Text(monthTitle(from: selectedDate))
                .font(.title)
            
            Button(
                action: {
                    changeMonth(1)
                },
                label: {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            )
        }
    }

    @ViewBuilder
    private var dayView: some View {
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: selectedDate))!
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                let components = (
                    0..<calendar.range(of: .day, in: .month, for: startDate)!.count)
                    .map {
                        calendar.date(byAdding: .day, value: $0, to: startDate)!
                    }
                
                ForEach(components, id: \.self) { date in
                    VStack {
                        Text(day(from: date))
                            .font(.caption)
                        Text("\(calendar.component(.day, from: date))")
                    }
                    .frame(width: 30, height: 30)
                    .padding(5)
                    .background(calendar.isDate(selectedDate, equalTo: date, toGranularity: .day) ? Color.green : Color.clear)
                    .cornerRadius(16)
                    .foregroundColor(calendar.isDate(selectedDate, equalTo: date, toGranularity: .day) ? .white : .black)
                    .onTapGesture {
                        selectedDate = date
                    }
                }
            }
        }
    }
    
    // MARK: - 블러 뷰
    private var blurView: some View {
        HStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color.white.opacity(1),
                        Color.white.opacity(0)
                    ]
                ),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: 20)
            .edgesIgnoringSafeArea(.leading)
            
            Spacer()
            
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color.white.opacity(1),
                        Color.white.opacity(0)
                    ]
                ),
                startPoint: .trailing,
                endPoint: .leading
            )
            .frame(width: 20)
            .edgesIgnoringSafeArea(.leading)
        }
    }
    
    // MARK: - Helper functions
    func monthTitle(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return dateFormatter.string(from: date)
    }
    
    func changeMonth(_ value: Int) {
        guard let date = calendar.date(
            byAdding: .month,
            value: value,
            to: selectedDate
        ) else {
            return
        }
        
        selectedDate = date
    }
    
    func day(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("E")
        return dateFormatter.string(from: date)
    }
}
