// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE ROBOTICS CORE
// SUB-MODULE: THREAD-SAFE POSE EXFILTRATION NODE (ANIMNODE_GUNDAMEXFILTRATION.CPP)
// COMPATIBILITY: UNREAL ENGINE 5.4+ PARALLEL ANIMATION WORKER THREADS
// ============================================================================

#include "AnimNode_GundamExfiltration.h"
#include "Animation/AnimInstanceProxy.h"

FAnimNode_GundamExfiltration::FAnimNode_GundamExfiltration()
{
}

void FAnimNode_GundamExfiltration::Initialize_AnyThread(const FAnimationInitializeContext& Context)
{
    FAnimNode_Base::Initialize_AnyThread(Context);
    SourcePose.Initialize(Context);
}

void FAnimNode_GundamExfiltration::Update_AnyThread(const FAnimationUpdateContext& Context)
{
    FAnimNode_Base::Update_AnyThread(Context);
    SourcePose.Update(Context);
}

void FAnimNode_GundamExfiltration::Evaluate_AnyThread(FPoseContext& Output)
{
    // 1. Evaluate the incoming source pose (straight out of the Control Rig node)
    SourcePose.Evaluate(Output);

    // 2. Thread-Safe extraction loop across critical skeletal bones
    const FBoneContainer& BoneContainer = Output.Pose.GetBoneContainer();
    
    // Example: Exfiltrate the Waist/Pelvis rotation after passive reflex calculation
    FSkeletonPoseBoneIndex WaistIndex(1); // Replace with your exact bone index lookup
    if (Output.Pose.IsValidIndex(WaistIndex))
    {
        FTransform WaistTransform = Output.Pose[WaistIndex];
        FQuat WaistRotation = WaistTransform.GetRotation();
        
        // 3. Dispatch directly to your asynchronous network thread
        // This avoids touching the main game thread, preventing viewport hitches
        // Example: FGundamHardwareSocket::SendBoneTelemetry(WaistRotation);
    }
}
