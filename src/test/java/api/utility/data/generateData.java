package api.utility.data;

public class generateData {
	public static String getEmail() {
		String prefix = "student_";
		String provider = "@tekschool.us";
		int random =(int)(Math.random()*10000);
		String email = prefix + random + provider;
		return email;
	
	}
//	Generate random phone number
	
	public static String getPhoneNumber() {
		String phoneNumber ="2";
		for(int i = 0; i <9; i++) {
			phoneNumber += (int)(Math.random()*10);
		}
		return phoneNumber;
		
	}
	
	public static String getLicensePlate() {
		String prefix = "AB";
		String suffix = "CD";
		int random = (int)(Math.random()*10000);
		String licensePlate  = prefix + random + suffix;
		return licensePlate;
	}
//	public static void main(String[] args) {
//		String number =getPhoneNumber();
//		System.out.println(number);
//	}
	
}
