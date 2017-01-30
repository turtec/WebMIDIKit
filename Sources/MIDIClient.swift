//
//  MIDIClient.swift
//  WebMIDIKit
//
//  Created by Adam Nemecek on 12/13/16.
//
//

import Foundation
import AVFoundation

internal final class MIDIClient: Comparable, Hashable {
    private(set) var ref = MIDIClientRef()

    init(callback: @escaping (UnsafePointer<MIDINotification>) -> ()) {
        MIDIClientCreateWithBlock("WebMIDIKit" as CFString, &self.ref) {
            callback($0)
        }
    }
//    init() {
//        MIDIClientCreateWithBlock("WebMIDIKit" as CFString, &self.ref) {
//            print($0.pointee)
//        }
//    }


    deinit {
        MIDIClientDispose(ref)
    }

    var hashValue: Int {
        return ref.hashValue
    }

    static func ==(lhs: MIDIClient, rhs: MIDIClient) -> Bool {
        return lhs.ref == rhs.ref
    }

    static func <(lhs: MIDIClient, rhs: MIDIClient) -> Bool {
        return lhs.ref < rhs.ref
    }
}
