# 도전100분


**"To do List를 쓰고 알람이 울리기 전에 그 일을 끝낸다!"**

해당 repo는 "도전100분 - Swift UIKit 기반 타이머/알람 앱 개발" 프로젝트를 담고 있습니다. 

<br>

### 📣 개발목표

* To do List와 각 태스크 별 시간 설정 기능 제작
* 각 태스크에 할당된 시간이 도과되면 푸시 알람이 나오도록 제작
* 실제 사용가능하도록 백그라운드 모드에서도 알람이 작동되도록 제작
* 추후 기능 추가 시 유지보수의 용이성을 생각한 설계

<br>

### 📣구현 기술

* Segue 위주의 화면 이동 처리
* 화면 이동 시 화면 간 데이터 전송 처리
* Notification, NoticationCenter를 활용한 백그라운드 처리
* 

<br>

### 📣개발환경

* Swift 5.5, iOS 15
* Xcode
* GitHub

<br>

### 📣주요 키워드

* Segue
* MVC
* UIKit
* NotificationCenter
* UNNotification
* Storyboard


### 📣개발 일정 기록

* 1.0버전
    * 초기 개발 모델입니다.
  
* 1.1버전
    * 버그 수정과 UI 일부 개선을 시도하였습니다.



<br>
<hr>

### 📣결과물

##### 앱스토어 도전100분 다운로드

https://apps.apple.com/kr/app/%EB%8F%84%EC%A0%84100%EB%B6%84/id6444036551


<br>

##### 메인페이지

![main](https://user-images.githubusercontent.com/98330884/203201345-370d0b1a-8645-46ce-a4f2-cb59fa30f561.png)

* 튜토리얼, 할 일 설정하기의 분기 페이지 입니다.
* 튜토리얼로 넘어갈 경우, 다시 이 페이지로 돌아올 수 있습니다.
* 할 일 설정하기로 넘어갈 경우 이 페이지로 돌아올 수 없습니다.

<br>

##### 할 일 설정하기 페이지

![step1](https://user-images.githubusercontent.com/98330884/203201374-4786eb29-e6bf-4eb1-b626-addbf2a39401.png)


* 상단의 + 버튼을 눌러 할 일을 설정할 수 있습니다.
* 할 일이 아무것도 없을 때, 시작을 누르면 경고 메시지가 나옵니다.

<br> 

##### 할 일 추가하기 페이지

![step2](https://user-images.githubusercontent.com/98330884/203201398-cf194871-9280-4da0-97de-1f15bca416c6.png)
![step3](https://user-images.githubusercontent.com/98330884/203201423-7fd009b8-0ad1-409d-ba4f-08911e8c5e5d.png)
![step4](https://user-images.githubusercontent.com/98330884/203201437-c0e1f8bb-4469-4808-bcb4-212adb2a21f3.png)

* 이 페이지에서는 할 일의 제목, 할당시간, 이모티콘을 설정할 수 있습니다.
* 새로운 일을 추가할 때, 추가 후 전체 할 일의 시간이 100분이 초과되면 경고 메시지가 나옵니다.


<br>


##### 타이머 시작 페이지

![step5](https://user-images.githubusercontent.com/98330884/203201463-bb870c16-6543-4e5c-be00-b4e581cdb1cf.png)

* 할 일 설정 페이지에서 추가한 할 일들이 차례로 타이머에 등장합니다.
* 각 할 일 별로 설정한 시간이 지나면 알람이 울립니다.
* 이전 할 일, 다음 할 일로 넘어갈 수 있습니다. 이에 따라 시간이 자동조정 됩니다.
* 리셋을 할 경우, 전체 리셋이 되며 처음부터 시작합니다.
* 잠금화면으로 가거나, 다른 앱을 사용하더라도 알림은 울립니다.
* (매너모드에서는 알림이 울리지 않습니다.)

<br>

<hr>

