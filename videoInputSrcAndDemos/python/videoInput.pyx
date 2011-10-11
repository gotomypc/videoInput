from libcpp cimport bool

cdef struct GUID:
  unsigned long Data1
  unsigned short Data2
  unsigned short Data3
  unsigned char Data4[8]

cdef extern from "videoInput.h":
  cdef void videoInput_setVerbose "videoInput::setVerbose"(bool)
  cdef int videoInput_listDevices "videoInput::listDevices"(bool)
  cdef char* videoInput_getDeviceName "videoInput::getDeviceName"(int)

  cdef cppclass videoInput:
    videoInput()

    void setUseCallback(bool)
    void setIdealFramerate(int, int)
    void setAutoReconnectOnFreeze(int, bool, int)

    bool setupDevice(int)
    bool setupDevice(int, int, int)

    bool setupDevice(int, int)
    bool setupDevice(int, int, int, int)

    bool setFormat(int, int)
    bool isFrameNew(int) 
    
    bool isDeviceSetup(int)
    unsigned char* getPixels(int, bool, bool)
    bool getPixels(int, unsigned char*, bool, bool)
    void showSettingsWindow(int)
    bool setVideoSettingFilter(int, long, long, long, bool)
    bool setVideoSettingFilterPct(int, long, float, long)
    bool getVideoSettingFilter(int, long, long&, long&, long, long&, long&, long&)

    bool setVideoSettingCamera(int, long, long, long, bool)
    bool setVideoSettingCameraPct(int, long, float, long)
    bool getVideoSettingCamera(int, long, long&, long&, long, long&, long&, long&)

    int  getWidth(int)
    int  getHeight(int)
    int  getSize(int)
    
    void stopDevice(int)
    
    bool restartDevice(int)

    int  devicesFound
    
    long propBrightness
    long propContrast
    long propHue
    long propSaturation
    long propSharpness
    long propGamma
    long propColorEnable
    long propWhiteBalance
    long propBacklightCompensation
    long propGain

    long propPan
    long propTilt
    long propRoll
    long propZoom
    long propExposure
    long propIris
    long propFocus
  
  cdef cppclass videoDevice:
    videoDevice()
    void setSize(int w, int h)
    void NukeDownstream(void *pBF)
    void destroyGraph()
    
    int videoSize
    int width
    int height
    int tryWidth
    int tryHeight
    
    void *pCaptureGraph
    void *pGraph
    void *pControl
    void *pVideoInputFilter
    void *pGrabberF
    void *pDestFilter
    void *streamConf
    void *pGrabber
    void *pAmMediaType
    
    void *pMediaEvent
    
    GUID videoType
    long formatType
    
    void * sgCallback
    
    bool tryDiffSize
    bool useCrossbar
    bool readyToCapture
    bool sizeSet
    bool setupStarted
    bool specificFormat
    bool autoReconnect
    int nFramesForReconnect
    unsigned long nFramesRunning
    int connection
    int storeConn
    int  myID
    long requestedFrameTime
    
    char nDeviceName[255]
    Py_UCS4 wDeviceName[255]
    
    unsigned char * pixels
    char * pBuffer


def setVerbose(bool verbose):
  videoInput_setVerbose(verbose)

def listDevices(silent=False):
  videoInput_listDevices(silent)

def getDeviceName(int deviceID):
  return videoInput_getDeviceName(deviceID)

cdef class VideoInput:
  cdef videoInput *thisptr

  def __cinit__(self):
    self.thisptr = new videoInput()

  def __dealloc__(self):
    del self.thisptr

  def setUseCallback(self, bool b):
    self.thisptr.setUseCallback(b)

  def setIdealFramerate(self, int a1, int a2):
    self.thisptr.setIdealFramerate(a1, a2)

  def setAutoReconnectOnFreeze(self, int a1, bool a2, int a3):
    self.thisptr.setAutoReconnectOnFreeze(a1, a2, a3)

  def setupDevice(self, int a1):
    return self.thisptr.setupDevice(a1)

  def setupDevice(self, int a1, int a2, int a3):
    return self.thisptr.setupDevice(a1, a2, a3)

  def setupDevice(self, int a1, int a2):
    return self.thisptr.setupDevice(a1, a2)

  def setupDevice(self, int a1, int a2, int a3, int a4):
    return self.thisptr.setupDevice(a1, a2)

  def setFormat(self, int a1, int a2):
    return self.thisptr.setFormat(a1, a2)

  def isFrameNew(self, int a1):
    return self.thisptr.isFrameNew(a1)

  def isDeviceSetup(self, int a1):
    return self.thisptr.isDeviceSetup(a1)

  def getPixels(self, int a1, bool a2, bool a3):
    return self.thisptr.getPixels(a1, a2, a3)

  def getPixels(self, int a1, unsigned char* a2, bool a3, bool a4):
    return self.thisptr.getPixels(a1, a2, a3, a4)

  def showSettingsWindow(self, int a1):
    self.thisptr.showSettingsWindow(a1)

  def setVideoSettingFilter(self, int a1, long a2, long a3, long a4, bool a5):
    return self.thisptr.setVideoSettingFilter(a1, a2, a3, a4, a5)

  def setVideoSettingFilterPct(self, int a1, long a2, float a3, long a4):
    return self.thisptr.setVideoSettingFilterPct(a1, a2, a3, a4)

  def getVideoSettingFilter(self, int a1, long a2, long a5):
    cdef long r3 = 0, r4 = 0, r6 = 0, r7 = 0, r8 = 0
    r = self.thisptr.getVideoSettingFilter(a1, a2, r3, r4, a5, r6, r7, r8)
    return (r, r3, r4, r6, r7, r8)

  def setVideoSettingCamera(self, int a1, long a2, long a3, long a4, bool a5):
    return self.thisptr.setVideoSettingCamera(a1, a2, a3, a4, a5)

  def setVideoSettingCameraPct(self, int a1, long a2, float a3, long a4):
    return self.thisptr.setVideoSettingCameraPct(a1, a2, a3, a4)

  def getVideoSettingCamera(self, int a1, long a2, long a5):
    cdef long r3 = 0, r4 = 0, r6 = 0, r7 = 0, r8 = 0
    r = self.thisptr.getVideoSettingCamera(a1, a2, r3, r4, a5, r6, r7, r8)
    return (r, r3, r4, r6, r7, r8)

  def getWidth(self, int i1):
    return self.thisptr.getWidth(i1)

  def getHeight(self, int i1):
    return self.thisptr.getHeight(i1)

  def getSize(self, int i1):
    return self.thisptr.getSize(i1)
    
  def stopDevice(self, int i1):
    self.thisptr.stopDevice(i1)
    
  def restartDevice(self, int i1):
    return self.thisptr.restartDevice(i1)

cdef class VideoDevice:
  cdef videoDevice *thisptr

  def __cinit__(self):
    self.thisptr = new videoDevice()

  def __dealloc__(self):
    del self.thisptr

  def setSize(self, int w, int h):
    self.thisptr.setSize(w, h)

  def destroyGraph(self):
    self.thisptr.destroyGraph()
