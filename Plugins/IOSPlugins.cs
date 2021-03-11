using System.Runtime.InteropServices;
using UnityEngine;

public  class IOSPlugins :MonoBehaviour{
	#if UNITY_IOS
	[DllImport ("__Internal")]
	private static extern void _OnUsingCamera(string caller);
	
	[DllImport ("__Internal")]
	private static extern void _OnUsingGallery(string caller);
	#endif

	public static void OnUsingGallery(string callerGameObject)
	{
    #if UNITY_IOS
		_OnUsingGallery(callerGameObject);
		Debug.Log("IOS  camera Access");
    #endif
	}
	public static void OnUsingCamera(string callerGameObject)
	{
	#if UNITY_IOS
        _OnUsingCamera(callerGameObject);
		Debug.Log("IOS  Gallery Access");
#endif
	}
 

}
