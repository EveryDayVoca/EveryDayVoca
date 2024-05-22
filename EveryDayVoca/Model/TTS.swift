//
//  TTS.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/22/24.
//

import AVFoundation

enum Language: String {
    case korean = "ko-KR"
    case english = "en-US"
}

class TTS {
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func play(str: String, language: Language) {
        let utterance = AVSpeechUtterance(string: str)
        utterance.voice = AVSpeechSynthesisVoice(language: language.rawValue)
        utterance.rate = 0.5
        utterance.pitchMultiplier = 0.8
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
}
