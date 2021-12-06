package de.schilken.timeout_examples;

import androidx.test.rule.ActivityTestRule;
import dev.flutter.plugins.integration_test.FlutterTestRunner;
import org.junit.Rule;
import org.junit.runner.RunWith;

import de.schilken.timeout_examples.MainActivity;

@RunWith(FlutterTestRunner.class)
public class MainActivityTest {
  @Rule
  public ActivityTestRule rule = new ActivityTestRule<>(MainActivity.class, true, false);
}