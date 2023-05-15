//
//  TypeData.swift
//  MC2-Team7-Fighring
//
//  Created by 정승균 on 2023/05/09.
//

import Foundation

enum AttachmentType: Int, CaseIterable {
    case secure = 0
    case anxious
    case avoidant
    case fearful
}

struct TypeData {
    static let name: [String] = [
        "든든한 국밥이",
        "나랑놀자 비그리",
        "시크한 복실이",
        "후덜덜 쫄쫄이"
    ]
    
    static let quotes: [[String]] = [
        ["나는 우리를 믿어!", "너무나도 행복해", "기쁠땐 기뻐하고 슬플 땐 슬퍼하면 되지"],
        ["네가 너무 보고싶어.", "너는 지금 뭘 하고 있을까 궁금해!", "너에게 더 좋은 사람이 되고 싶어!"],
        ["네가 느끼는 감정을 잘 표현 못하지만, 너에게는 내 모든 걸 다 말할 수 있어!", "네가 나에게 이렇게 소중하다는 걸 알게 해줘서 고마워.", "천천히 다가와죠..."],
        ["우리 사이는 딱 두 걸음 정도가 적당해!", "내가 잘 할 수 있을까?"]
    ]

    static let tags: [[String]] = [
        ["행복해", "표현의 귀재", "우리_모두_최고"],
        ["보고싶어", "지금모해","너와함께"],
        ["슬로우스타터", "밀당고수", "표현초보"],
        ["내가잘할수있을까", "낯가리는_부끄럼쟁이", "시간이필요해"]
    ]

    static let description: [String] = [
        "국밥이는 매사에 자신감이 넘치며 주변 사람들에게 안정감을 주는 든든한 인물이랍니다!\n강점을 활용하면 많은 도움을 줄 수 있을 거라 확신합니다!\n\n뿐만 아니라 감정을 눈치채거나 표현하는 능력이 출중합니다. 때문에 가끔 화를 쉽게 내곤 하지만 금방 사그라들고 뒤끝은 없다는 점!\n지금까지 해왔던대로 행동한다면 모두가 만족하는 연애를 할 수 있을거라 장담합니다!",
        "비그리는 상처를 잘 받을지도 몰라요. 주변의 작은 행동이 크게 다가올 때도 있답니다.\n또한, 감정을 표현하는 데에 서툴기 때문에 연인이 서운해할 수도 있어요. 오글거리더라도 솔직하게 감정을 말한다면 연인에게 큰 감동을 줄 수 있을거에요.\n비그리에게도 사랑한다고 자주 표현해준다면 아주 좋아한다는 사실!\n비글이가 감정에 휘둘리지 않는다면, 모두가 만족하는 연애를 할 수 있을거에요!",
        "복실이에게는 가까워지는 속도가 중요해요. 너무 급하게 거리를 좁힌다면 부담스러워할 때도 있답니다.\n시간을 두고 천천히 가까워진다면 편안함과 안정감을 갖고 색다른 귀여운 모습을 볼 수 있을거에요.\n함께 즐길 수 있는 운동과 같은 취미를 찾는다면 조금 더 효과적으로 유대감을 형성할 수 있다는 사실!\n고민이 있을 때 혼자만 끙끙 앓기보단 연인에게 공유한다면 서로가 발전할 수 있는 계기가 될 거에요:D",
        "우리 쫄쫄이는 가까운 정서관계를 맺는 건 조금 불편하게 느껴요..! 주변 사람을 깊게 신뢰하지는 않지만, 친밀감에는 강한 욕구를 갖고 있어요.\n 연인은 순수한 사랑으로 온전한 당신의 편이라는 점을 알고 다가가보는건 어떨까요?\n또한, 쫄쫄이는 스스로를 과소평가하는 경향이 있어요. 오늘 하루 너는 정말 멋진 사람이야! 외쳐봅시다\n 본인 그대로의 모습이 충분히 멋있답니다! 조급해하지말고 시간을 두고 차근차근 친해져봐요!"

    ]
    
    static let imageName: [String] = [
        "Retriever_secure",
        "Beagle_anxious",
        "Bichon_avoidant",
        "Chihuahua_fearful"
    ]
}
