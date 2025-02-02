#include <CTXAudio.h>

#include <thread>
#include <chrono>

using namespace CTXEngine;
using namespace CTXEngine::Audio;

int main()
{
	// Initialize the audio engine
	CTXEngine::Audio::Audio::Init();
	// Load audio source from file
	auto source = AudioSource::LoadFromFile("assets/BackgroundMusic.mp3", false);
	// Make it loop forever
	source.SetLoop(true);
	// Play audio source
	CTXEngine::Audio::Audio::Play(source);

	auto frontLeftSource = AudioSource::LoadFromFile("assets/FrontLeft.ogg", true);
	frontLeftSource.SetGain(5.0f);
	frontLeftSource.SetPosition(-5.0f, 0.0f, 5.0f);
	CTXEngine::Audio::Audio::Play(frontLeftSource);

	auto frontRightSource = AudioSource::LoadFromFile("assets/FrontRight.ogg", true);
	frontRightSource.SetGain(5.0f);
	frontRightSource.SetPosition(5.0f, 0.0f, 5.0f);
	CTXEngine::Audio::Audio::Play(frontRightSource);

	auto movingSource = AudioSource::LoadFromFile("assets/Moving.ogg", true);
	movingSource.SetGain(5.0f);
	movingSource.SetPosition(5.0f, 0.0f, 5.0f);

	int sourceIndex = 0;
	const int sourceCount = 3;
	AudioSource* sources[] = { &frontLeftSource, &frontRightSource, &movingSource };

	float xPosition = 5.0f;
	float playFrequency = 3.0f; // play sounds every 3 seconds
	float timer = playFrequency;

	std::chrono::steady_clock::time_point lastTime = std::chrono::steady_clock::now();
	while (true)
	{
		std::chrono::steady_clock::time_point currentTime = std::chrono::steady_clock::now();
		std::chrono::duration<float> delta = currentTime - lastTime;
		lastTime = currentTime;

		if (timer < 0.0f)
		{
			timer = playFrequency;
			CTXEngine::Audio::Audio::Play(*sources[sourceIndex++ % sourceCount]);
		}

		// Moving sound source
		if (sourceIndex == 3)
		{
			xPosition -= delta.count() * 2.0f;
			movingSource.SetPosition(xPosition, 0.0f, 5.0f);
		}
		else
		{
			xPosition = 5.0f;
		}

		timer -= delta.count();

		using namespace std::literals::chrono_literals;
		std::this_thread::sleep_for(5ms);
	}
}