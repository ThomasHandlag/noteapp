import 'dart:developer' as dev;
import 'package:google_generative_ai/google_generative_ai.dart';

class SecretAPI {
  static GenerativeModel generativeModelCreator() {
    const apiKey = String.fromEnvironment('API_KEY');
    return GenerativeModel(model: 'gemini-pro', apiKey: apiKey, generationConfig: GenerationConfig(
      candidateCount: 1,
      maxOutputTokens: 500,
      temperature: 1,
      topK: 64,
      topP: 0.95
    ), safetySettings: [
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
      SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
      SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
      
    ]);
  }

  static GenerativeModel model = generativeModelCreator();
}
