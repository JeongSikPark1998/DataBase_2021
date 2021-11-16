# DataBase_2021
KNU DataBase Project_Team04_Consultation WebService
HTML -> JSP  DATA
LOGIN	
	(Pro, Stu, Manager)
	ID
	PW
	Uco
학생 
	1. 신청 하는 페이지
		- Course, Follow, General
			- 교수 선택
	1-1. 신청 가능 내역
		- 줄 단위로 가능한 상담 현황 출력
		- consultation (뺄 것: CSId, CStuName, CNum, CPId, CSUco)
	1-2 신청하기 페이지
		- 가능 신청 인원 (동시성 제어)
		- consultation에서 학생 신청 개수 + max reserv num 비교 -> 값이 같으면 막기 혹은 교수까지 세서 많으면 막기하든가
		- Consultation Consult_info 묶을 방법이 없는 (table 전격 수정)
		* 신청시 상담 정보까지 모두 기입할 것
		insert가 두 번 일어나야함
	
	-> 마이페이지로 넘어가기
		
	1-3. 버튼으로 마이 페이지로 넘어가기
		- 자기가 신청한 consultation list를 보여주고 (옆에 취소 버튼)
		- Consult_info 수정
		- Pw 업데이트
		- 자기 정보 열람

교수
	2. 자기 개설 상담 현황
		- 개설하기 창으로 이동 버튼
		- pw 업데이트
		- 자기 정보 열람
		- 상담 취소
		- 완료 상담 (완료하기)
	
	2-1 개설하기 페이지
		- Conuslt_type, Space, max, time, date
		
	-> 첫 번째 화면

관리자
	3. 관리자 페이지
		- 학교 코드 추가
		- 학교 삭제
		- 현재 학교의 개설된 정보를 보여준 뒤 학교 전공 및 강좌 추가





