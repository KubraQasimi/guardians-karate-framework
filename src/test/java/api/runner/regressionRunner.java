package api.runner;

import com.intuit.karate.junit5.Karate;

public class regressionRunner {
	@Karate.Test
	public Karate runTest() {
		//address for the feature file
		//and tags
		
		return Karate.run("classpath:features")
				.tags("@regression");
	}
}
