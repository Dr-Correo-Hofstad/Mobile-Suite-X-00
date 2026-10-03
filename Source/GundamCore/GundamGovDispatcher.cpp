// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE ROBOTICS CORE
// SUB-MODULE: GOVERNMENT TELEMETRY DISPATCH SINK (GUNDAMGOVDISPATCHER.CPP)
// COMPATIBILITY: UNREAL ENGINE 5.4+ THREAD-SAFE NETWORK EXTENSIONS
// ============================================================================

#include "GundamGovDispatcher.h"
#include "Networking.h"
#include "Sockets.h"
#include "SocketSubsystem.h"

UGundamGovDispatcher::UGundamGovDispatcher()
{
    PrimaryComponentTick.bCanEverTick = true;
}

void UGundamGovDispatcher::BeginPlay()
{
    Super::BeginPlay();
    
    // Configure secure remote government monitoring network destination
    FIPv4Address GovServerAddress;
    FIPv4Address::Parse(TEXT("10.0.1.50"), GovServerAddress); // Target government endpoint IP
    GovEndpoint = FIPv4Endpoint(GovServerAddress, 9999);
    
    // Build lightweight, non-blocking outbound UDP network pipe
    SenderSocket = FUdpSocketBuilder(TEXT("GovTelemetryOutput"))
        .AsNonBlocking()
        .AsReusable();
        
    if (SenderSocket)
    {
        UE_LOG(LogTemp, Warning, TEXT("[UNIVAC-IX] Secure Government Telemetry Dispatcher Active on Port 9999."));
    }
}

void UGundamGovDispatcher::DispatchSkeletalTelemetry(const FString& InSerializedPayload)
{
    if (!SenderSocket) return;

    // Convert serialized string array to byte sequence array
    FTCHARToUTF8 Converter(*InSerializedPayload);
    int32 BytesSent = 0;
    
    // Broadcast the raw tracker array packets out to the government node
    SenderSocket->SendTo((const uint8*)Converter.Get(), Converter.Length(), BytesSent, *GovEndpoint.ToInternetAddr());
}

void UGundamGovDispatcher::EndPlay(const EEndPlayReason::Type EndPlayReason)
{
    if (SenderSocket)
    {
        SenderSocket->Close();
        ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->DestroySocket(SenderSocket);
    }
    Super::EndPlay(EndPlayReason);
}
