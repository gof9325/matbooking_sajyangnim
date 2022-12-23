# ✨ matbooking_sajyangnim (맛북킹_사장님) ✨

> 기다림을 줄여주는 가게 예약 어플 - 사장님

### 사용된 기술 👉
SwiftUI, Combine, Web Socket, Alamofire, Auth0, REST API

### 라이브러리 관리 👉
SPM

### 사용된 디자인 패턴 👉
MVVM

**주요기능:**
- [가게 정보 관리](#가게 정보 관리)
- [로그인&로그아웃](#로그인&로그아웃)
- [예약 목록 확인](#예약 목록 확인)
- [손님과의 채팅](#손님과의 채팅)

## 가게 정보 관리

## 로그인&로그아웃
**✔️ 로그인**</br>
<img src="https://user-images.githubusercontent.com/39786810/209288354-bdbc5997-0398-4cad-8f95-f628e1e3c6de.gif" width="200" height="400"/>

〰️ Flow 〰️
1. '시작하기' 버튼 탭
2. Auth0에서 인증 토큰 받아오기</br>
  a. Auth0에 회원 정보가 없을 경우 : 로그인 실패</br>
  b. Auth0에 회원 정보가 있을 경우 : 3번으로 이동</br>
3. matbooking 회원 정보 확인</br>
  a. matbooking 회원 정보가 없을 경우 : [회원가입](#회원가입) 으로 이동</br>
  b. matbooking 회원 정보가 있을 경우 : 정상 로그인 및 [가게 목록 조회/검색](#가게 목록 조회/검색) 으로 이동</br>

## 예약 목록 확인
<img src="https://user-images.githubusercontent.com/39786810/209310814-398b2157-1bbe-4a02-a6f0-b4693fa901ac.gif" width="200" height="400"/>

〰️ Flow 〰️
1. 하단의 TabView 중 '홈' 화면에서 가게 목록 조회
2. 상단의 검색란에 원하는 가게의 이름 입력

## 손님과의 채팅
