// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE ROBOTICS CORE
// SUB-MODULE: UNREAL PHYSICS CONTROLLER NODE (GUNDAMNETWORKRECEIVER.CPP)
// COMPATIBILITY: UNREAL ENGINE 5.x COMPLIANT SKELETAL SYSTEM
// ============================================================================

#include "GundamNetworkReceiver.h"
#include "Networking.h"
#include "Sockets.h"
#include "SocketSubsystem.h"

UGundamNetworkReceiver::UGundamNetworkReceiver()
{
    PrimaryComponentTick.bCanEverTick = true;
}

void UGundamNetworkReceiver::BeginPlay()
{
    Super::BeginPlay();
    
    // Configure local socket configuration loop
    FIPv4Address Address;
    FIPv4Address::Parse(TEXT("127.0.0.1"), Address);
    FIPv4Endpoint Endpoint(Address, 8888);
    
    ListenSocket = FUdpSocketBuilder(TEXT("GundamTelemetryReceiver"))
        .AsNonBlocking()
        .AsReusable()
        .BoundToEndpoint(Endpoint);
        
    if (ListenSocket)
    {
        UE_LOG(LogTemp, Warning, TEXT("[UNIVAC-IX] Unreal Network Listener successfully bound to Port 8888."));
    }
}

void UGundamNetworkReceiver::TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction)
{
    Super::TickComponent(DeltaTime, TickType, ThisTickFunction);

    uint32 Size;
    TSharedRef<FInternetAddr> Sender = ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->CreateInternetAddr();
    
    // Continually drain the UDP buffer every frame
    while (ListenSocket && ListenSocket->HasPendingData(Size))
    {
        TArray<uint8> ReceivedData;
        ReceivedData.SetNumUninitialized(Size);
        
        int32 BytesRead = 0;
        if (ListenSocket->RecvFrom(ReceivedData.GetData(), ReceivedData.Num(), BytesRead, *Sender))
        {
            FString ReceivedString = FString(AnsiCharToTChar((const char*)ReceivedData.GetData()));
            
            // Trigger Blueprint Event or parse JSON here to extract parameters 
            // example: UpdateJointMotors(ReceivedString);
            
            UE_LOG(LogTemp, Log, TEXT("[UNIVAC-IX] Packet ingested by Unreal physics core: %s"), *ReceivedString);
        }
    }
}

void UGundamNetworkReceiver::EndPlay(const EEndPlayReason::Type EndPlayReason)
{
    if (ListenSocket)
    {
        ListenSocket->Close();
        ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->DestroySocket(ListenSocket);
    }
    Super::EndPlay(EndPlayReason);
}
