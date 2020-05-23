workspace "CTXAudio"
	architecture "x86_64"
	startproject "CTXAudio-Examples"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}
	
	flags
	{
		"MultiProcessorCompile"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

group "Dependencies"
	include "CTXAudio/Libraries/OpenAL"
	include "CTXAudio/Libraries/libogg"
	include "CTXAudio/Libraries/Vorbis"
group ""

project "CTXAudio"
	location "CTXAudio"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	
	targetdir ("Build/bin/" .. outputdir .. "/%{prj.name}/lib")   --bin
	objdir ("Build/bin/" .. outputdir .. "/%{prj.name}/obj")  -- bin-obj

	files
	{
		"%{prj.name}/Sources/**.h",
		"%{prj.name}/Sources/**.cpp"
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"AL_LIBTYPE_STATIC"
	}

	includedirs
	{
		"%{prj.name}/src",
		"CTXAudio/Libraries/OpenAL/include",
		"CTXAudio/Libraries/OpenAL/src",
		"CTXAudio/Libraries/OpenAL/src/common",
		"CTXAudio/Libraries/libogg/include",
		"CTXAudio/Libraries/Vorbis/include",
		"CTXAudio/Libraries/minimp3"
	}

	links
	{
		"OpenAL",
		"Vorbis"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		defines "CTX_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "CTX_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "CTX_DIST"
		runtime "Release"
		optimize "on"

project "CTXAudio-Examples"
	location "CTXAudio-Examples"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("Build/bin/" .. outputdir .. "/%{prj.name}/exe") 
	objdir ("Build/bin/" .. outputdir .. "/%{prj.name}/obj") 

	files
	{
		"%{prj.name}/Sources/**.h",
		"%{prj.name}/Sources/**.cpp"
	}

	includedirs
	{
		"CTXAudio/Sources"
	}

	links
	{
		"CTXAudio"
	}

	filter "system:windows"
		systemversion "latest"
		
	filter "configurations:Debug"
		defines "CTX_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "CTX_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "CTX_DIST"
		runtime "Release"
		optimize "on"
